from flask import Flask, render_template, request, redirect, url_for, make_response, jsonify
from flask_socketio import SocketIO, send, join_room, leave_room
import psycopg2, random, string, os, logging, time

app = Flask(__name__)

#connect DB
try: conn = psycopg2.connect("dbname='namegame' user='webserver_namegame' host='localhost' password='sqlpass123'")
except: print("I am unable to connect to the database")
conn.autocommit = True


# DATABASE FUNCTIONS

def q_sql(query,data=None,get_header=False):
    # TODO: fix SQL injection literally everywhere
    cur = conn.cursor()
    cur.execute(query,data)
    output = ""
    try: 
        output = cur.fetchall()
        if get_header: output = [[i[0] for i in cur.description],output]
    except: pass
    finally:
        cur.close()
        return output

def db_cookie(user_id,username=None,ip=None):
    result = ""
    if user_id: 
        query = f"select user_id, username from users where user_id = %(user_id)s limit 1"
        result = q_sql(query,{'user_id':user_id})
    if not result or not user_id:
        if not username: username = ''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(5))
        query = f"insert into users (username, ip_address) values (%(username)s, %(ip)s); select user_id, username from users order by user_id desc limit 1"
        result = q_sql(query,{'username':username, 'ip':ip})
    print("user", result)
    return result

def header_zip_query(query, data=None, multi=False):
    header, data = q_sql(query, data=data, get_header=True)
    if multi: return [dict(zip(header, d)) for d in data]
    return dict(zip(header, data[0]))

def db_user_instance(user_id,username,game_id):
    result = ""
    query = f"select user_inst_id from user_instance where user_id = %(user_id)s and game_id = %(game_id)s limit 1"
    result = q_sql(query,{'user_id':user_id, 'game_id':game_id})
    if not result:
        query = f"insert into user_instance (user_id, username, game_id) values (%(user_id)s, %(username)s, %(game_id)s); select user_inst_id from user_instance order by user_inst_id desc limit 1"
        result = q_sql(query,{'user_id':user_id, 'username':username, 'game_id':game_id})
    print("user_inst", result)
    return result

def get_user_inst_id(user_id,game_id): 
    user_insts = q_sql(f"select user_inst_id from user_instance where game_id = %(game_id)s and user_id = %(user_id)s", {'user_id':user_id, 'game_id':game_id})
    if not user_insts:
        raise Exception(f"Could not find user_inst for game_id = {game_id} and user_id={user_id}")
    return user_insts[0][0]

def create_game_sql(form):
    first_round = ''
    for x in ['round1', 'round2', 'round3', 'round4']:
        if not first_round: first_round = int(x[-1])
        if x not in form.keys(): form[x]="0"
        elif form[x]=="on": form[x]="1"
    form['round']= first_round
    print(form)
    query = f"""insert into games (active, stage, date_created, round, number_teams, number_names, time_limit, round1, round2, round3, round4, game_name) 
    values (TRUE, 1, NOW(), %(round)s, %(number_teams)s, %(number_names)s, %(time_limit)s, %(round1)s, %(round2)s, %(round3)s, %(round4)s, %(game_name)s ); select game_id from games order by game_id desc limit 1"""
    return q_sql(query, form)[0][0]

def insert_names_sql(user_inst_id,game_id,names):
    for name in names:
        q_sql("insert into names (user_inst_id,game_id,name) values (%(user_inst_id)s,%(game_id)s,%(name)s)", {'user_inst_id':user_inst_id,'game_id':game_id,'name':name})

def get_mp3_number_sql(start_or_stop): 
    total, current = q_sql(f"select number_{start_or_stop}s, current_{start_or_stop} from mp3_order")[0]
    q_sql(f"update mp3_order set current_{start_or_stop}= %(current)s",{'current':(current+1)%total})
    return current

def create_teams_sql(game_id, number_teams):
    for i in range(number_teams):
        team_name = 'Team '+''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(5))
        q_sql(f"insert into teams (game_id,team_name) values (%(game_id)s, %(team_name)s)",{'game_id':game_id,'team_name':team_name})

def get_teams(game_id, get_player_id=False):
    player_list = q_sql(f"select user_id,username,team_id from user_instance where game_id = %(game_id)s", {'game_id':game_id})
    players = {x[0]:x[1] for x in player_list}
    teammembers = {x:[] for x in set([y[2] for y in player_list])}
    if get_player_id: [teammembers[z].append(x) for x,y,z in player_list]
    else: [teammembers[z].append(y) for x,y,z in player_list]
    return players, teammembers

def is_turn_order_init(game_id):
    return bool(q_sql(f"select * from teams_turn_order where game_id = %(game_id)s", {'game_id':game_id}))

def init_turn_order(game_id):
    game_deets = get_game_deets(game_id)
    players, teammembers = get_teams(game_id, get_player_id=True)
    number_teams = game_deets['number_teams']
    teams = list(teammembers.keys())
    query = f"""insert into teams_turn_order (game_id, teams_array, number_teams, current_team) values (%(game_id)s,%(teams_array)s,%(number_teams)s, 0);
    insert into players_turn_order (team_id, players_array, number_players, current_player) values """ + ",".join([f"({team},'{str(set(teammembers[team]))}',{len(teammembers[team])},0)" for team in teams])
    q_sql(query, {'game_id':game_id, 'teams_array':str(set(teams)), 'number_teams':number_teams })

def get_turn_order(game_id, get_index=False):
    teams = header_zip_query(f"select * from teams_turn_order where game_id = %(game_id)s", data={'game_id':game_id})
    teams_array, number_teams, current_team = teams['teams_array'], teams['number_teams'], teams['current_team']
    team = teams_array[current_team]
    players = header_zip_query(f"select * from players_turn_order where team_id = %(team)s", data={'team':team})
    players_array, number_players, current_player = players['players_array'], players['number_players'], players['current_player']
    player = players_array[current_player]
    if get_index: return team, number_teams, current_team, number_players, current_player
    return team, player

def advance_turn_order(game_id):
    # TODO: if a player disconnects during their turn, they get another turn. This logic should happen serverside instead
    team, number_teams, current_team, number_players, current_player = get_turn_order(game_id,get_index=True)
    q_sql(f"update players_turn_order set current_player = %(current_player)s where team_id = %(team)s ; update teams_turn_order set current_team = %(current_team)s where game_id = %(game_id)s", {'current_player':(current_player+1)%number_players, 'team':team, 'current_team':(current_team+1)%number_teams, 'game_id':game_id})

def advance_round_sql(game_id):
    round = get_round(game_id)
    game_deets = get_game_deets(game_id)
    all_rounds = [x  for x in range(1,5) if bool(game_deets[f'round{x}'])]
    next_index = all_rounds.index(round)+1
    if next_index >= len(all_rounds):
        q_sql(f"update games set stage=4 where game_id=%(game_id)s",{'game_id':game_id})
    else:
        q_sql(f"update games set round = %(round)s",{'round':all_rounds[next_index]})
        emit_current_round(game_id)

def add_turn_sql(game_id,user_id):
    user_inst_id = get_user_inst_id(user_id,game_id)
    round = get_round(game_id)
    time_limit = q_sql(f"select time_limit from games where game_id = %(game_id)s",{'game_id':game_id})[0][0]
    has_ongoing_turns = q_sql(f"select user_inst_id from turns where game_id = %(game_id)s and round = %(round)s and now() < time_finish and active",{'game_id':game_id,'round':round,'user_inst_id':user_inst_id})
    if has_ongoing_turns:
        username = q_sql(f"select username from user_instance where user_inst_id = %(user_inst_id)s",{'user_inst_id':has_ongoing_turns[0][0]})[0][0]
        alert(game_id,f"ERROR: {username} has an ongoing turn, please concede",user_id)
    else: 
        q_sql(f"insert into turns (user_inst_id,game_id,round,time_start,time_finish,active) values (%(user_inst_id)s,%(game_id)s,%(round)s,now(),now() + interval '%(time_limit)s second', TRUE)",{'user_inst_id':user_inst_id,'game_id':game_id,'round':round,'time_limit':time_limit})
        socketio.emit('start_timer', room=f"game{game_id}")

def end_turn_sql(game_id,user_id):
    user_inst_id = get_user_inst_id(user_id,game_id)
    round = get_round(game_id)
    turn_id = q_sql(f"select turn_id from turns where user_inst_id = %(user_inst_id)s and game_id = %(game_id)s and round = %(round)s order by turn_id desc limit 1",{'user_inst_id':user_inst_id,'game_id':game_id,'round':round})[0][0]
    q_sql(f"update turns set active = FALSE where turn_id = %(turn_id)s",{'turn_id':turn_id})


def score_answer_sql(game_id, user_id, name_id, success):
    user_inst_id = get_user_inst_id(user_id, game_id)
    round = get_round(game_id)
    name = get_name_by_id(name_id)
    team_id = get_teamid_by_userinst(user_inst_id)
    turn_id, time_start = q_sql(f"select turn_id, time_start from turns where user_inst_id = %(user_inst_id)s and game_id = %(game_id)s and round = %(round)s order by turn_id desc limit 1",{'user_inst_id':user_inst_id,'game_id':game_id,'round':round})[0]
    latest_time_finish = q_sql(f"select time_finish from answers where turn_id = %(turn_id)s order by answer_id desc limit 1",{'turn_id':turn_id})
    if latest_time_finish: time_start = latest_time_finish[0][0]
    query = f"insert into answers (game_id, team_id, user_inst_id, name_id, name, success, round, time_start, time_finish, turn_id) values (%(game_id)s, %(team_id)s, %(user_inst_id)s, %(name_id)s, %(name)s, %(success)s, %(round)s, %(time_start)s, now(), %(turn_id)s)"
    q_sql(query, {'game_id':game_id, 'team_id':team_id, 'user_inst_id':user_inst_id, 'name_id':name_id, 'name':name, 'success':success, 'round':round, 'turn_id':turn_id, 'time_start':time_start})

def get_scores(game_id, is_team=False):
    if is_team:  results = q_sql(f"select t.team_name, count(*) from answers a join teams t on a.team_id = t.team_id where success = 1 and a.game_id = %(game_id)s group by t.team_name order by count(*) desc",{'game_id':game_id})
    else: results = q_sql(f"select u.username, count(*) from answers a join user_instance u on a.user_inst_id = u.user_inst_id where success = 1 and a.game_id = %(game_id)s group by u.username order by count(*) desc",{'game_id':game_id})
    scorers, scores = [], []
    [(scorers.append(x),scores.append(y)) for x,y in results]
    return scorers, scores

def random_shuffle_teams_sql(game_id):
    if not get_game_stage(game_id) == 1: return
    teams = [x[0] for x in get_team_names(game_id)]
    user_insts = [x[0] for x in get_user_inst_ids_by_game(game_id)]
    random.shuffle(teams)
    random.shuffle(user_insts)
    players_per_team = -(-len(user_insts)//len(teams))
    for team_id in teams:
        for _ in range(players_per_team):
            if user_insts:
                user_inst_id = user_insts.pop()
                q_sql(f"update user_instance set team_id = %(team_id)s where user_inst_id = %(user_inst_id)s", {'team_id':team_id, 'user_inst_id':user_inst_id})

def player_team_change_sql(user_id,team_id,game_id): 
    if get_game_stage(game_id) == 1:
        q_sql(f"update user_instance set team_id= %(team_id)s where user_id = %(user_id)s and game_id=%(game_id)s", {'user_id':user_id,'game_id':game_id,'team_id':team_id})

def get_random_default_name(): return random.choice(q_sql(f"select name from default_names"))[0]

def get_game_stage(game_id): return q_sql(f"select stage from games where game_id = %(game_id)s", {'game_id':game_id})[0][0]

def get_user_inst_ids_by_game(game_id): return q_sql(f"select user_inst_id from user_instance where game_id = %(game_id)s", {'game_id':game_id})

def get_game_deets(game_id): return header_zip_query(f"select * from games where game_id = %(game_id)s", data = {'game_id':game_id})

def get_round(game_id): return q_sql(f"select round from games where game_id = %(game_id)s", {'game_id':game_id})[0][0]

def get_team_names(game_id): return q_sql(f"select team_id,team_name from teams where game_id = %(game_id)s", {'game_id':game_id})

def delete_game_sql(game_id):  q_sql(f"update games set active=FALSE where game_id = %(game_id)s",{'game_id':game_id})

def kick_user_sql(game_id,user_id): q_sql(f"delete from user_instance where game_id = %(game_id)s and user_id = %(user_id)s", {'user_id':user_id, 'game_id':game_id})

def get_who_hasnt_written_name_sql(game_id): return header_zip_query(f"select user_id, username from user_instance where game_id = %(game_id)s and user_inst_id not in ( select user_inst_id from names where game_id = %(game_id)s )", data={'game_id':game_id}, multi = True)

def get_next_name_sql(game_id, round): return header_zip_query(f"select * from names where game_id = %(game_id)s and name_id not in (select name_id from answers where game_id = %(game_id)s and success=1 and round=%(round)s)", data={'game_id':game_id,'round':round}, multi=True)

def get_name_by_id(name_id): return q_sql(f"select name from names where name_id = %(name_id)s",{'name_id':name_id})[0][0]

def get_teamid_by_userinst(user_inst_id): return q_sql(f"select team_id from user_instance where user_inst_id= %(user_inst_id)s",{'user_inst_id':user_inst_id})[0][0]

def advance_game_sql(game_id,stage): q_sql(f"update games set stage = %(stage)s where game_id = %(game_id)s", {'game_id':game_id,'stage':stage})

def get_joinable_games_for_user(user_id): return q_sql(f"select game_id, game_name from games where active=TRUE and (stage = 1 or game_id in (select game_id from user_instance where user_id = %(user_id)s)) order by game_id desc", {'user_id':user_id})

def get_players_by_game_id(game_id): return q_sql(f"select user_id, username from user_instance where game_id = %(game_id)s", {'game_id':game_id})

def update_username(new_username,user_id,user_inst_id): q_sql(f"update users set username = %(new_username)s where user_id = %(user_id)s; update user_instance set username= %(new_username)s where user_inst_id = %(user_inst_id)s",{'user_id':user_id,'user_inst_id':user_inst_id,'new_username':new_username})

def update_team_name(team_id, new_team_name): q_sql(f"update teams set team_name = %(new_team_name)s where team_id = %(team_id)s;", {'team_id':team_id, 'new_team_name':new_team_name})

def has_user_submitted_names(user_inst_id): return q_sql(f"select name_id from names where user_inst_id = %(user_inst_id)s", {'user_inst_id':user_inst_id})

def get_latest_round_from_answers(game_id): return q_sql(f"select round from answers where game_id = %(game_id)s order by round desc limit 1", {'game_id':game_id})[0][0]












# SOCKET IO


socketio = SocketIO(app=app,logger=logging)

@socketio.on('connect')
def test_connect(auth):
    user_id = request.cookies["user_id"]
    username = request.cookies["username"]
    game_id = request.args["game_id"]
    ip = request.environ.get('HTTP_X_REAL_IP', request.remote_addr) 
    join_room(f"user{user_id}")
    join_room(f"game{game_id}")
    print(f"\nUser_ID: {user_id}, Username: {username}, IP: {ip}\n")#,request.args["t"], request,"\n")

@socketio.on('emit_players')
def emit_players(game_id,user_id=None):
    players, teammembers = get_teams(game_id)
    socketio.emit('emit_players', [players, teammembers], room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('emit_teams')
def emit_teams(game_id,user_id=None):
    team_names = get_team_names(game_id)
    teams = {x[0]:x[1] for x in team_names}
    socketio.emit('emit_teams', teams , room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('random_shuffle_teams')
def random_shuffle_teams(game_id): 
    random_shuffle_teams_sql(game_id)
    emit_players(game_id)

@socketio.on('advance_game_emit')
def advance_game_emit(game_id):
    socketio.emit('advance_game_emit',"", room=f"game{game_id}")

@socketio.on('delete_game')
def delete_game(game_id): delete_game_sql(game_id)

@socketio.on('deletion_kick')
def deletion_kick(game_id,by_user,user_id=None):
    if user_id == None: 
        socketio.emit('deletion_kick',by_user, room=f"game{game_id}")
    else: 
        kick_user_sql(game_id,user_id)
        socketio.emit('deletion_kick',by_user, room=f"user{user_id}")
        emit_players(game_id)

@socketio.on('refresh_join_game')
def refresh_join_game():
    socketio.emit('refresh_join_game','', room="gamejoin")

@socketio.on('who_hasnt_written_name')
def emit_who_hasnt_written_name(game_id,user_id=None):
    who_hasnt = get_who_hasnt_written_name_sql(game_id) 
    socketio.emit('who_hasnt_written_name', who_hasnt, room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('emit_current_turn')
def emit_current_turn(game_id,user_id=None):
    current_team_id, current_turn_user_id  = get_turn_order(game_id)
    socketio.emit('emit_current_turn', [current_team_id, current_turn_user_id], room=f"user{user_id}" if user_id else f"game{game_id}")
    #socketio.emit('your_turn','', room=f"user{current_turn_user_id}")

@socketio.on('emit_next_name')
def emit_next_name(game_id,user_id):
    round = get_round(game_id)
    names = get_next_name_sql(game_id, round)
    if names:
        i = random.randint(0,len(names)-1)
        socketio.emit('emit_next_name',names[i], room=f"user{user_id}")
    else:
        advance_round(game_id)
        advance_turn(game_id)
        socketio.emit('emit_next_name',"no more names", room=f"user{user_id}")

@socketio.on('emit_current_round')
def emit_current_round(game_id,user_id=None,is_new_round=False):
    round = get_round(game_id)
    socketio.emit('emit_current_round',[round,is_new_round], room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('alert')
def alert(game_id,message,user_id=None):
    socketio.emit('alert',message, room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('advance_turn')
def advance_turn(game_id,user_id=None):
    advance_turn_order(game_id)
    emit_current_turn(game_id)

@socketio.on('advance_round')
def advance_round(game_id,user_id=None):
    advance_round_sql(game_id)
    emit_current_round(game_id,is_new_round=True)

@socketio.on('start_timer')
def start_timer(game_id,user_id):
    add_turn_sql(game_id,user_id)

@socketio.on('stop_timer')
def stop_timer(game_id,user_id):
    socketio.emit('stop_timer', room=f"game{game_id}")
    end_turn_sql(game_id,user_id)

@socketio.on('score_answer')
def score_answer(game_id, user_id, name_id, success): 
    score_answer_sql(game_id, user_id, name_id, success)

@socketio.on('get_mp3_number')
def get_mp3_number(user_id,start_or_stop):
    start_or_stop = "start" if start_or_stop == "start" else "stop" if start_or_stop == "stop" else "error"
    current = get_mp3_number_sql(start_or_stop)
    socketio.emit('get_mp3_number',{"mp3_number":current, "start_or_stop":start_or_stop}, room= f"user{user_id}")

@socketio.on('emit_scores')
def emit_scores(game_id,user_id,is_team=False):
    res = get_scores(game_id, is_team)
    socketio.emit('emit_scores',[res,is_team], room= f"user{user_id}")

@socketio.on('get_random_name')
def get_random_name():
    return get_random_default_name()










# APP ROUTES

# homepage
@app.route('/', methods=["GET"])
def homepage():
    resp = make_response(render_template('homepage.html'))
    user_id = request.cookies.get('user_id')
    ip = request.environ.get('HTTP_X_REAL_IP', request.remote_addr) 
    user_id, username = db_cookie(user_id=user_id,username=None,ip=ip)[0]
    resp.set_cookie('user_id', str(user_id))
    resp.set_cookie('username', username)
    return resp


#create / modify / delete game
@app.route('/create_game', methods=["GET"])
def create_game():
    return render_template('create-game.html')


@app.route('/add_game', methods=["POST"])
def add_game():
    form = dict(request.form)
    number_teams = int(form["number_teams"])
    game_id = create_game_sql(form)
    create_teams_sql(game_id, number_teams)
    refresh_join_game()
    return redirect(url_for('join_game'))


@app.route('/advance_game', methods=['POST'])
def advance_game():
    data = request.get_json()
    game_id, stage = data["game_id"], data["stage"]
    advance_game_sql(game_id,stage)
    if stage == 3:
        if not is_turn_order_init(game_id): 
            init_turn_order(game_id)
            for _ in range(random.randint(0,15)): advance_turn_order(game_id)
    advance_game_emit(game_id)
    return make_response("",200)


@app.route('/join_game', defaults={'game_id': None})
@app.route('/join_game/<game_id>', methods=["GET"])
def join_game(game_id):    
    user_id = request.cookies.get('user_id')
    if not game_id:
        ip = request.environ.get('HTTP_X_REAL_IP', request.remote_addr) 
        user_id, username = db_cookie(user_id=user_id,username=None,ip=ip)[0]
        games_sql = get_joinable_games_for_user(user_id)
        return render_template('join-game.html',games=games_sql,username=username)
    game_deets = get_game_deets(game_id)
    if game_deets["stage"] == 1:
        return redirect(url_for('lobby',game_id=game_id))
    elif get_user_inst_id(user_id,game_id):
        if game_deets["stage"] == 2:
            return redirect(url_for('write_names',game_id=game_id))
        if game_deets["stage"] == 3:
            return redirect(url_for('name_game',game_id=game_id))
        if game_deets["stage"] == 4:
            return redirect(url_for('graphs',game_id=game_id))
        else: return redirect(url_for('join_game'))
    else: return redirect(url_for('join_game'))


#lobby
@app.route('/lobby/<game_id>', methods=["GET"])
def lobby(game_id):
    # TODO: if game has started, redirect to the started game
    game_deets = get_game_deets(game_id)
    user_id = request.cookies.get('user_id')
    username = request.cookies.get('username')
    db_user_instance(user_id,username,game_id)
    players = get_players_by_game_id(game_id)
    teams = get_team_names(game_id)
    user_inst_id = get_user_inst_id(user_id,game_id)
    emit_players(game_id)
    return render_template('lobby.html', game_id=game_id, game_deets=game_deets, username=username, players=players, teams=teams, user_inst_id=user_inst_id)


@app.route('/username_change', methods=["POST"])
def username_change():
    data = request.get_json()
    new_username, user_inst_id, game_id = data["new_username"], data["user_inst_id"], data["game_id"]
    user_id = request.cookies.get("user_id")
    print("new_username:",new_username,"user_id:",user_id)
    update_username(new_username,user_id,user_inst_id)
    resp = make_response("")
    resp.set_cookie('user_id', str(user_id))
    resp.set_cookie('username', new_username)
    emit_players(game_id)
    return resp


@app.route('/team_name_change', methods=["POST"])
def team_name_change():
    data = request.get_json()
    new_team_name, team_id, game_id = data["new_team_name"], data["team_id"], data["game_id"]
    print("new_team_name:",new_team_name,"team_id:",team_id)
    update_team_name(team_id, new_team_name)
    emit_teams(game_id)
    return make_response("",200)


@app.route('/player_team_change', methods=["POST"])
def player_team_change():
    data = request.get_json()
    user_id, team_id, game_id = data["user_id"], data["team_id"], data["game_id"]
    print("player_team_change:",user_id,"team_id:",team_id)
    player_team_change_sql(user_id,team_id,game_id)
    emit_players(game_id)
    return make_response("",200)


#write names
@app.route('/write_names/<game_id>', methods=["GET"])
def write_names(game_id):
    game_deets = get_game_deets(game_id)
    user_id = request.cookies.get('user_id')
    user_inst_id = get_user_inst_id(user_id,game_id)
    players = get_players_by_game_id(game_id)
    return render_template('write-names.html', user_id=user_id, game_id=game_id, game_deets=game_deets, players=players, user_inst_id=user_inst_id)


@app.route('/submit_names', methods=["POST"])
def submit_names():
    data = request.get_json()
    user_id, game_id, names = data["user_id"], data["game_id"], data["names"]
    user_inst_id = get_user_inst_id(user_id,game_id)
    if not(has_user_submitted_names(user_inst_id)):
        insert_names_sql(user_inst_id,game_id,names)
        emit_who_hasnt_written_name(game_id)
        return make_response(jsonify(""),200)
    else:
        return make_response(jsonify("You've already submitted names"),200)


#name game
@app.route('/name_game/<game_id>', methods=["GET"])
def name_game(game_id):
    # TODO: handle when game has started without user
    game_deets = get_game_deets(game_id)
    user_id = request.cookies.get('user_id')
    username = request.cookies.get('username')
    user_inst_id = get_user_inst_id(user_id,game_id)
    teams = get_team_names(game_id)
    players = get_players_by_game_id(game_id)
    team_id = get_teamid_by_userinst(user_inst_id)
    if game_deets['stage'] >= 4: return redirect(url_for(f"graphs", game_id=game_id))
    return render_template('name-game.html', user_id=user_id, game_id=game_id, game_deets=game_deets, players=players, username=username, user_inst_id=user_inst_id, teams=teams, team_id=team_id)

#graphs
@app.route('/graphs/<game_id>', methods=["GET"])
def graphs(game_id):
    user_id = request.cookies.get('user_id')
    game_deets = get_game_deets(game_id)
    round = get_latest_round_from_answers(game_id)
    return render_template('graphs.html', game_id=game_id, user_id=user_id, round=round, game_deets=game_deets)

@app.route('/readme', methods=["GET"])
def readme():
    return render_template('readme.html')









# START APP
if __name__ == '__main__':
    logging.basicConfig(filename='log.log',level=logging.INFO)
    socketio.run(
        app,
        #host="192.168.137.1",
        #host="192.168.0.106",
        host="0.0.0.0",
        #port=8, 
        port=65112, 
        log_output=True,
        debug=True,
        use_reloader=True
    ) # 192.168.0.106, port=8,