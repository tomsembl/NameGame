from flask import Flask, render_template, request, redirect, url_for, make_response, jsonify
from flask_socketio import SocketIO, join_room
import sqlite3, random, string, logging, time, json, os
from os.path import join, dirname, abspath
from socket import gethostbyname, gethostname

app = Flask(__name__)


# DATABASE FUNCTIONS

#time_elapsed = 0
def q_sql(query,data=False,get_header=False):
    #start = time.time()
    cur = conn.cursor()
    if data: cur.execute(query,data)
    else: cur.execute(query)
    output = ""
    try: 
        output = cur.fetchall()
        if get_header: output = [[i[0] for i in cur.description],output]
    except: pass
    finally:
        cur.close()
        #global time_elapsed
        #time_elapsed += time.time() - start
        #print(f"Time elapsed: {time_elapsed}")
        return output

def db_cookie(user_id,username=None,ip=None):
    result = ""
    if user_id: 
        query = f"select user_id, username from users where user_id = :user_id limit 1"
        result = q_sql(query,{'user_id':user_id})
    if not result or not user_id:
        if not username: username = ''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(5))        
        q_sql("insert into users (username, ip_address) values (:username, :ip)",{'username':username, 'ip':ip})
        result = q_sql("select user_id, username from users order by user_id desc limit 1")
    return result

def header_zip_query(query, data=None, multi=False):
    header, data = q_sql(query, data=data, get_header=True)
    if multi: return [dict(zip(header, d)) for d in data]
    return dict(zip(header, data[0]))

def db_user_instance(user_id,username,game_id):
    result = ""
    query = "select user_inst_id from user_instance where user_id = :user_id and game_id = :game_id limit 1"
    result = q_sql(query,{'user_id':user_id, 'game_id':game_id})
    if not result:
        q_sql("insert into user_instance (user_id, username, game_id) values (:user_id, :username, :game_id)",{'user_id':user_id, 'username':username, 'game_id':game_id})
        result = "select user_inst_id from user_instance order by user_inst_id desc limit 1"
    #print("user_inst", result)
    return result

def get_user_inst_id(user_id,game_id): 
    user_insts = q_sql(f"select user_inst_id from user_instance where game_id = :game_id and user_id = :user_id", {'user_id':user_id, 'game_id':game_id})
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
    #print(form)
    query = f"""insert into games (active, stage, date_created, round, number_teams, number_names, time_limit, round1, round2, round3, round4, game_name) 
    values (TRUE, 1, datetime('now','localtime'), :round, :number_teams, :number_names, :time_limit, :round1, :round2, :round3, :round4, :game_name )"""
    q_sql(query, form)
    return q_sql("select game_id from games order by game_id desc limit 1")[0][0]

def insert_names_sql(user_inst_id,game_id,names):
    for name in names:
        q_sql("insert into names (user_inst_id,game_id,name) values (:user_inst_id,:game_id,:name)", {'user_inst_id':user_inst_id,'game_id':game_id,'name':name})

def get_mp3_number_sql(start_or_stop): 
    total, current = q_sql(f"select number_{start_or_stop}s, current_{start_or_stop} from mp3_order")[0]
    q_sql(f"update mp3_order set current_{start_or_stop}= :current",{'current':(current+1)%total})
    return current

def create_teams_sql(game_id, number_teams):
    for i in range(number_teams):
        team_name = 'Team '+''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(5))
        q_sql(f"insert into teams (game_id,team_name) values (:game_id, :team_name)",{'game_id':game_id,'team_name':team_name})

def get_teams(game_id, get_player_id=False):
    player_list = q_sql(f"select user_id,username,team_id from user_instance where game_id = :game_id", {'game_id':game_id})
    players = {x[0]:x[1] for x in player_list}
    teammembers = {x:[] for x in set([y[2] for y in player_list])}
    if get_player_id: [teammembers[z].append(x) for x,y,z in player_list]
    else: [teammembers[z].append(y) for x,y,z in player_list]
    return players, teammembers

def is_turn_order_init(game_id):
    return bool(q_sql(f"select * from teams_turn_order where game_id = :game_id", {'game_id':game_id}))

def init_turn_order(game_id):
    game_deets = get_game_deets(game_id)
    players, teammembers = get_teams(game_id, get_player_id=True)
    number_teams = game_deets['number_teams']
    teams = list(teammembers.keys())
    q_sql("insert into teams_turn_order (game_id, teams_array, number_teams, current_team) values (:game_id,:teams_array,:number_teams, 0)",{'game_id':game_id,'teams_array':str(teams),'number_teams':number_teams})
    query = "insert into players_turn_order (team_id, players_array, number_players, current_player) values " + ",".join([f"({team},'{str(teammembers[team])}',{len(teammembers[team])},0)" for team in teams])
    q_sql(query, {'game_id':game_id, 'teams_array':str(set(teams)), 'number_teams':number_teams })

def get_turn_order(game_id, get_index=False, get_all=False):
    teams = header_zip_query(f"select * from teams_turn_order where game_id = :game_id", data={'game_id':game_id})
    teams_array, number_teams, current_team = json.loads(teams['teams_array']), teams['number_teams'], teams['current_team']
    team = teams_array[current_team]
    players = header_zip_query(f"select * from players_turn_order where team_id = :team", data={'team':team})
    players_array, number_players, current_player = json.loads(players['players_array']), players['number_players'], players['current_player']
    player = players_array[current_player]
    if get_index: return team, number_teams, current_team, number_players, current_player
    if get_all: 
        teams_player_order = header_zip_query(f"select * from players_turn_order where team_id in (select team_id from teams where game_id = :game_id)", data={'game_id':game_id}, multi=True)
        for i,x in enumerate(teams_player_order):
            teams_player_order[i]['players_array'] = json.loads(x['players_array'])
        return teams_array, number_teams, current_team, teams_player_order
    return team, player

def advance_turn_order(game_id):
    team, number_teams, current_team, number_players, current_player = get_turn_order(game_id,get_index=True)
    q_sql("update players_turn_order set current_player = :current_player where team_id = :team", {'current_player':(current_player+1)%number_players, 'team':team}) 
    q_sql("update teams_turn_order set current_team = :current_team where game_id = :game_id", {'current_team':(current_team+1)%number_teams, 'game_id':game_id})

def advance_round_sql(game_id):
    round = get_round(game_id)
    game_deets = get_game_deets(game_id)
    all_rounds = [x  for x in range(1,5) if bool(game_deets[f'round{x}'])]
    next_index = all_rounds.index(round)+1
    if next_index >= len(all_rounds):
        q_sql(f"update games set stage=4 where game_id=:game_id",{'game_id':game_id})
    else:
        q_sql(f"update games set round = :round",{'round':all_rounds[next_index]})
        emit_current_round(game_id)

def add_turn_sql(game_id,user_id):
    round = get_round(game_id)
    #has_ongoing_turns = q_sql(f"select user_inst_id from turns where game_id = :game_id and round = :round and datetime('now','localtime') < time_finish and active",{'game_id':game_id,'round':round})
    #if has_ongoing_turns:
        #username = q_sql(f"select username from user_instance where user_inst_id = :user_inst_id",{'user_inst_id':has_ongoing_turns[0][0]})[0][0]
        #alert(game_id,f"ERROR: {username} has an ongoing turn, please concede",user_id)
    #else: 
    time_limit = str(q_sql(f"select time_limit from games where game_id = :game_id",{'game_id':game_id})[0][0])
    user_inst_id = get_user_inst_id(user_id,game_id)
    q_sql(f"insert into turns (user_inst_id,game_id,round,time_start,time_finish,active) values (:user_inst_id,:game_id,:round,datetime('now','localtime'), datetime(datetime('now','localtime'),:time_limit || ' second'),TRUE)",{'user_inst_id':user_inst_id,'game_id':game_id,'round':round,'time_limit':time_limit})
    socketio.emit('start_timer', room=f"game{game_id}")

def end_turn_sql(game_id): q_sql(f"update turns set active = FALSE where game_id = :game_id and active",{'game_id':game_id})

def score_answer_sql(game_id, user_id, name_id, success):
    user_inst_id = get_user_inst_id(user_id, game_id)
    round = get_round(game_id)
    name = get_name_by_id(name_id)
    team_id = get_teamid_by_userinst(user_inst_id)
    turn_id, time_start = q_sql(f"select turn_id, time_start from turns where user_inst_id = :user_inst_id and game_id = :game_id and round = :round order by turn_id desc limit 1",{'user_inst_id':user_inst_id,'game_id':game_id,'round':round})[0]
    latest_time_finish = q_sql(f"select time_finish from answers where turn_id = :turn_id order by answer_id desc limit 1",{'turn_id':turn_id})
    if latest_time_finish: time_start = latest_time_finish[0][0]
    query = f"insert into answers (game_id, team_id, user_inst_id, name_id, name, success, round, time_start, time_finish, turn_id) values (:game_id, :team_id, :user_inst_id, :name_id, :name, :success, :round, :time_start, datetime('now','localtime'), :turn_id)"
    q_sql(query, {'game_id':game_id, 'team_id':team_id, 'user_inst_id':user_inst_id, 'name_id':name_id, 'name':name, 'success':success, 'round':round, 'turn_id':turn_id, 'time_start':time_start})

def get_scores(game_id, is_team=False):
    if is_team:  results = q_sql(f"select t.team_name, count(*) from answers a join teams t on a.team_id = t.team_id where success = 1 and a.game_id = :game_id group by t.team_name order by count(*) desc",{'game_id':game_id})
    else: results = q_sql(f"select u.username, count(*) from answers a join user_instance u on a.user_inst_id = u.user_inst_id where success = 1 and a.game_id = :game_id group by u.username order by count(*) desc",{'game_id':game_id})
    scorers, scores = [], []
    [(scorers.append(x),scores.append(y)) for x,y in results]
    return scorers, scores

def random_shuffle_teams_sql(game_id):
    if not get_game_stage(game_id) == 1: return
    teams = [x[0] for x in get_team_names(game_id)]
    user_insts = [x[0] for x in get_user_inst_ids_by_game(game_id)]
    random.shuffle(teams)
    random.shuffle(user_insts)
    current_team_index = 0
    for user_inst_id in user_insts:
        q_sql(f"update user_instance set team_id = :team_id where user_inst_id = :user_inst_id",{'team_id':teams[current_team_index],'user_inst_id':user_inst_id})
        current_team_index = (current_team_index + 1) % len(teams)

def get_line_graph_data(game_id, is_team=False):
    rounds = list(map(lambda x: x[0],q_sql(f"select distinct(round) from answers where game_id = :game_id order by round",{'game_id':game_id})))
    #teams
    all_rounds_data = []
    for round in rounds:
        if is_team: data = q_sql(f"select t.team_name, count(*) from answers a join teams t on a.team_id = t.team_id where success = 1 and round = :round and a.game_id = :game_id group by t.team_name order by count(*) desc", {'round':round,'game_id':game_id})
        else: data = q_sql(f"select u.username, count(*) from answers a join user_instance u on u.user_inst_id = a.user_inst_id where success = 1 and round = :round and a.game_id = :game_id group by u.username order by count(*) desc", {'round':round,'game_id':game_id})
        all_rounds_data.append(data)
    dicti = {x:[] for x in [y[0] for y in all_rounds_data[0]]}
    dicti2 = {x:[] for x in [y[0] for y in all_rounds_data[0]]}
    for round in all_rounds_data:
        for player in round:
            dicti2[player[0]].append(player[1]+sum(dicti[player[0]]))
            dicti[player[0]].append(player[1])
    return({"cummulative":dicti2,"normal":dicti,"rounds":rounds})

def update_username(new_username,user_id,user_inst_id): 
    q_sql(f"update users set username = :new_username where user_id = :user_id ",{'user_id':user_id,'new_username':new_username})
    q_sql(f"update user_instance set username= :new_username where user_inst_id = :user_inst_id",{'user_inst_id':user_inst_id,'new_username':new_username})

def player_team_change_sql(user_id,team_id,game_id): 
    if get_game_stage(game_id) == 1: q_sql(f"update user_instance set team_id= :team_id where user_id = :user_id and game_id=:game_id", {'user_id':user_id,'game_id':game_id,'team_id':team_id})

def get_random_default_name(): return random.choice(q_sql(f"select name from default_names"))[0]

def get_game_stage(game_id): return q_sql(f"select stage from games where game_id = :game_id", {'game_id':game_id})[0][0]

def get_user_inst_ids_by_game(game_id): return q_sql(f"select user_inst_id from user_instance where game_id = :game_id", {'game_id':game_id})

def get_game_deets(game_id): return header_zip_query(f"select * from games where game_id = :game_id", data = {'game_id':game_id})

def get_round(game_id): return q_sql(f"select round from games where game_id = :game_id", {'game_id':game_id})[0][0]

def get_team_names(game_id): return q_sql(f"select team_id,team_name from teams where game_id = :game_id", {'game_id':game_id})

def delete_game_sql(game_id):  q_sql(f"update games set active=FALSE where game_id = :game_id",{'game_id':game_id})

def kick_user_sql(game_id,user_id): q_sql(f"delete from user_instance where game_id = :game_id and user_id = :user_id", {'user_id':user_id, 'game_id':game_id})

def get_who_hasnt_written_name_sql(game_id): return header_zip_query(f"select user_id, username from user_instance where game_id = :game_id and user_inst_id not in ( select user_inst_id from names where game_id = :game_id )", data={'game_id':game_id}, multi = True)

def get_next_name_sql(game_id, round): return header_zip_query(f"select * from names where game_id = :game_id and name_id not in (select name_id from answers where game_id = :game_id and success=1 and round=:round)", data={'game_id':game_id,'round':round}, multi=True)

def get_name_by_id(name_id): return q_sql(f"select name from names where name_id = :name_id",{'name_id':name_id})[0][0]

def get_teamid_by_userinst(user_inst_id): return q_sql(f"select team_id from user_instance where user_inst_id= :user_inst_id",{'user_inst_id':user_inst_id})[0][0]

def advance_game_sql(game_id,stage): q_sql(f"update games set stage = :stage where game_id = :game_id", {'game_id':game_id,'stage':stage})

def get_joinable_games_for_user(user_id): return header_zip_query(f"select game_id, game_name from games where active=TRUE and (stage = 1 or game_id in (select game_id from user_instance where user_id = :user_id)) order by game_id desc", {'user_id':user_id}, multi=True)

def get_players_by_game_id(game_id): return q_sql(f"select user_id, username from user_instance where game_id = :game_id", {'game_id':game_id})

def update_team_name(team_id, new_team_name): q_sql(f"update teams set team_name = :new_team_name where team_id = :team_id", {'team_id':team_id, 'new_team_name':new_team_name})

def has_user_submitted_names(user_inst_id): return q_sql(f"select name_id from names where user_inst_id = :user_inst_id", {'user_inst_id':user_inst_id})

def get_latest_round_from_answers(game_id): return q_sql(f"select round from answers where game_id = :game_id order by round desc limit 1", {'game_id':game_id})[0][0]












# SOCKET IO


socketio = SocketIO(app=app,logger=logging)

@socketio.on('connect')
def test_connect(auth):
    user_id = request.cookies.get('user_id')#["user_id"]
    #username = request.cookies.get('username')#["username"]
    game_id = request.args["game_id"]
    #ip = request.environ.get('HTTP_X_REAL_IP', request.remote_addr) 
    join_room(f"user{user_id}")
    join_room(f"game{game_id}")
    #print(f"\nUser_ID: {user_id}, Username: {username}, IP: {ip}\n")

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
    end_turn_sql(game_id)

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

@socketio.on('emit_line_graph_data')
def emit_line_graph_data(game_id,user_id,is_team=False):
    res = get_line_graph_data(game_id,is_team=False)
    socketio.emit('emit_line_graph_data',[res,is_team], room= f"user{user_id}")

@socketio.on('get_random_name')
def get_random_name():
    return get_random_default_name()

@socketio.on('emit_turn_order')
def emit_turn_order(game_id,user_id):
    teams_array, number_teams, current_team, teams_player_order = get_turn_order(game_id,get_all=True)
    #teams_objs = {y : next(x for x in teams_player_order if x["team_id"] == y) for y in teams_array}
    #obj = {"current_team":current_team, "number_teams":number_teams,"teams_array":teams_array, "teams_objs":teams_objs}
    obj = {"current_team":current_team, "number_teams":number_teams,"teams_array":teams_array, "teams_player_order":teams_player_order}
    socketio.emit('emit_turn_order',obj, room= f"user{user_id}")

@socketio.on('team_name_change')
def team_name_change(new_team_name, team_id, game_id):
    update_team_name(team_id, new_team_name)
    emit_teams(game_id)

@socketio.on('player_team_change')
def player_team_change(user_id, team_id, game_id):
    player_team_change_sql(user_id,team_id,game_id)
    emit_players(game_id)











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
            for _ in range(random.randint(0,7)): advance_turn_order(game_id)
    advance_game_emit(game_id)
    return make_response("",200)


@app.route('/join_game', defaults={'game_id': None})
@app.route('/join_game/<game_id>', methods=["GET"])
def join_game(game_id):    
    user_id = request.cookies.get('user_id')
    if not user_id:
        return redirect(url_for('homepage'))
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
    if not user_id:
        return redirect(url_for('homepage'))
    username = request.cookies.get('username')
    db_user_instance(user_id,username,game_id)
    players, teammembers = get_teams(game_id)
    team_names = get_team_names(game_id)
    teams = {x[0]:x[1] for x in team_names}
    user_inst_id = get_user_inst_id(user_id,game_id)
    emit_players(game_id)
    return render_template('lobby.html', user_id=user_id, game_id=game_id, game_deets=game_deets, username=username, players=players, teams=teams, teammembers=teammembers, user_inst_id=user_inst_id)


@app.route('/username_change', methods=["POST"])
def username_change():
    data = request.get_json()
    new_username, user_inst_id, game_id = data["new_username"], data["user_inst_id"], data["game_id"]
    user_id = request.cookies.get("user_id")
    update_username(new_username,user_id,user_inst_id)
    resp = make_response("")
    resp.set_cookie('user_id', str(user_id))
    resp.set_cookie('username', new_username)
    emit_players(game_id)
    return resp


#write names
@app.route('/write_names/<game_id>', methods=["GET"])
def write_names(game_id):
    game_deets = get_game_deets(game_id)
    user_id = request.cookies.get('user_id')
    if not user_id:
        return redirect(url_for('homepage'))
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
    if not user_id:
        return redirect(url_for('homepage'))
    team_names = get_team_names(game_id)
    teams = {x[0]:x[1] for x in team_names}
    user_inst_id = get_user_inst_id(user_id,game_id)
    team_id = get_teamid_by_userinst(user_inst_id)
    players, teammembers = get_teams(game_id,get_player_id=True)
    numPlayers = len(players.keys())
    if game_deets['stage'] >= 4: return redirect(url_for(f"graphs", game_id=game_id))
    return render_template('name-game.html', user_id=user_id, game_id=game_id, game_deets=game_deets, players=players, teams=teams, team_id=team_id, teammembers=teammembers, numPlayers=numPlayers)

#graphs
@app.route('/graphs/<game_id>', methods=["GET"])
def graphs(game_id):
    user_id = request.cookies.get('user_id')
    if not user_id:
        return redirect(url_for('homepage'))
    game_deets = get_game_deets(game_id)
    round = get_latest_round_from_answers(game_id)
    return render_template('graphs.html', game_id=game_id, user_id=user_id, round=round, game_deets=game_deets)

@app.route('/readme', methods=["GET"])
def readme():
    return render_template('readme.html')









# START APP
if __name__ == '__main__':

    #connect DB
    db_path = join(dirname(abspath(__file__)), 'namegame.db')
    isSetup =  os.path.exists(db_path)
    conn = sqlite3.connect(db_path, check_same_thread=False, isolation_level=None)
    if not isSetup:
        print("Setting up DB")
        script_path = join(dirname(abspath(__file__)), 'sql/full_db_script_no_data_sqlite.sql')
        with open(script_path, 'r') as f:
            script = f.read()
        cur = conn.cursor()
        cur.executescript(script)
        cur.close()
        print("DB setup complete")
    print("Running Site")
    logging.basicConfig(filename='log.log',level=logging.INFO)
    app.config['ssl_context'] = 'adhoc'
    socketio.run(
        app,
        host=gethostbyname(gethostname()),
        #host="192.168.137.1",
        #host="192.168.1.138",
        #host="10.0.0.102",
        #host='0.0.0.0',
        #port=8, 
        port=42069, 
        ssl_context='adhoc'
        #log_output=True,
        #debug=True,
        #use_reloader=True
    )
