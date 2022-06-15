from flask import Flask, render_template, request, redirect, url_for, make_response, jsonify
from flask_socketio import SocketIO, send, join_room, leave_room
import psycopg2, random, string, os


#connect DB
try: conn = psycopg2.connect("dbname='namegame' user='postgres' host='localhost' password='sqlpass123'")
except: print("I am unable to connect to the database")
conn.autocommit = True


# DATABASE FUNCTIONS

def query_sql(query,get_header=False):
    # TODO: fix SQL injection literally everywhere
    cur = conn.cursor()
    cur.execute(query)
    output = ""
    try: 
        output = cur.fetchall()
        if get_header: output = [[i[0] for i in cur.description],output]
    except: pass
    finally:
        cur.close()
        return output

def db_cookie(user_id,username=None):
    result = ""
    if user_id: 
        query = f"select user_id, username from users where user_id = {user_id}"
        result = query_sql(query)
    if not result or not user_id:
        if not username: username = ''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(5))
        query = f"insert into users (username) values ('{username}'); select user_id, username from users order by user_id desc"
        result = query_sql(query)
    print("user", result)
    return result

def header_zip_query(query, multi=False):
    header, data = query_sql(query, get_header=True)
    if multi: return [dict(zip(header, d)) for d in data]
    return dict(zip(header, data[0]))

def db_user_instance(user_id,username,game_id):
    result = ""
    query = f"select user_inst_id from user_instance where user_id = {user_id} and game_id = {game_id} limit 1"
    result = query_sql(query)
    if not result:
        query = f"insert into user_instance (user_id, username, game_id) values ({user_id},'{username}',{game_id}); select user_inst_id from user_instance order by user_inst_id desc limit 1"
        result = query_sql(query)
    print("user_inst", result)
    return result

def get_user_inst_id(user_id,game_id): 
    user_insts = query_sql(f"select user_inst_id from user_instance where game_id={game_id} and user_id={user_id}")
    if not user_insts:
        raise Exception(f"Could not find user_inst for game_id={game_id} and user_id={user_id}")
    return user_insts[0][0]

def get_game_deets(game_id): return header_zip_query(f"select * from games where game_id = {game_id}")

def get_round(game_id): return query_sql(f"select round from games where game_id = {game_id}")[0][0]

def get_teams(game_id, get_player_id=False):
    player_list = query_sql(f"select user_id,username,team_id from user_instance where game_id = {game_id}")
    players = {x[0]:x[1] for x in player_list}
    teammembers = {x:[] for x in set([y[2] for y in player_list])}
    if get_player_id: [teammembers[z].append(x) for x,y,z in player_list]
    else: [teammembers[z].append(y) for x,y,z in player_list]
    return players, teammembers

def turn_order_is_init(game_id):
    return bool(query_sql(f"select * from teams_turn_order where game_id ={game_id}"))

def init_turn_order(game_id):
    game_deets = get_game_deets(game_id)
    players, teammembers = get_teams(game_id, get_player_id=True)
    number_teams = game_deets['number_teams']
    teams = list(teammembers.keys())
    query = f"""insert into teams_turn_order (game_id, teams_array, number_teams, current_team) values ({game_id},'{str(set(teams))}',{number_teams},0);
    insert into players_turn_order (team_id, players_array, number_players, current_player) values """ + ",".join([f"({team},'{str(set(teammembers[team]))}',{len(teammembers[team])},0)" for team in teams])
    query_sql(query)

def get_turn_order(game_id, get_index=False):
    teams = header_zip_query(f"select * from teams_turn_order where game_id ={game_id}")
    teams_array, number_teams, current_team = teams['teams_array'], teams['number_teams'], teams['current_team']
    team = teams_array[current_team]
    players = header_zip_query(f"select * from players_turn_order where team_id = {team}")
    players_array, number_players, current_player = players['players_array'], players['number_players'], players['current_player']
    player = players_array[current_player]
    if get_index: return team, number_teams, current_team, number_players, current_player
    return team, player

def advance_turn_order(game_id):
    # TODO: if a player disconnects during their turn, they get another turn. This logic should happen serverside instead
    team, number_teams, current_team, number_players, current_player = get_turn_order(game_id,get_index=True)
    query_sql(f"update players_turn_order set current_player = {(current_player+1)%number_players} where team_id={team};update teams_turn_order set current_team = {(current_team+1)%number_teams} where game_id={game_id}")

def advance_round_sql(game_id):
    round = get_round(game_id)
    game_deets = get_game_deets(game_id)
    all_rounds = [x  for x in range(1,5) if bool(game_deets[f'round{x}'])]
    next_index = all_rounds.index(round)+1
    if next_index >= len(all_rounds):
        query_sql(f"update games set stage=4 where game_id={game_id}")
    else:
        query_sql(f"update games set round = {all_rounds[next_index]}")
        emit_current_round(game_id)

def get_scores(game_id, is_team=False):
    if is_team:  results = query_sql(f"select t.team_name, count(*) from answers a join teams t on a.team_id = t.team_id where success = 1 and a.game_id = {game_id} group by t.team_name order by count(*) desc")
    else: results = query_sql(f"select u.username, count(*) from answers a join user_instance u on a.user_inst_id = u.user_inst_id where success = 1 and a.game_id = {game_id} group by u.username order by count(*) desc")
    scorers, scores = [], []
    [(scorers.append(x),scores.append(y)) for x,y in results]
    return scorers, scores

app = Flask(__name__)
socketio = SocketIO(app=app)


# SOCKET IO
@socketio.on('message')
def handleMessage(msg):
	print('Message: ' + msg)
	send(msg, broadcast=True)

@socketio.on('connect')
def test_connect(auth):
    user_id = request.cookies["user_id"]
    game_id = request.args["game_id"]
    join_room(f"user{user_id}")
    join_room(f"game{game_id}")
    print("\n","user_id:",request.cookies["user_id"],"username:",request.cookies["username"],request.args["t"], request,"\n")

@socketio.on('emit_players')
def emit_players(game_id,user_id=None):
    players, teammembers = get_teams(game_id)
    socketio.emit('emit_players', [players, teammembers], room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('emit_teams')
def emit_teams(game_id,user_id=None):
    team_names = query_sql(f"select team_id,team_name from teams where game_id = {game_id}")
    teams = {x[0]:x[1] for x in team_names}
    socketio.emit('emit_teams', teams , room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('advance_game_emit')
def advance_game_emit(game_id):
    socketio.emit('advance_game_emit',"", room=f"game{game_id}")

@socketio.on('delete_game')
def delete_game(game_id):
    query_sql(f"update games set active=FALSE where game_id = {game_id}")

@socketio.on('deletion_kick')
def deletion_kick(game_id,by_user,user_id=None):
    if user_id == None: 
        socketio.emit('deletion_kick',by_user, room=f"game{game_id}")
    else: 
        query_sql(f"delete from user_instance where game_id = {game_id} and user_id = {user_id}")
        socketio.emit('deletion_kick',by_user, room=f"user{user_id}")
        emit_players(game_id)

@socketio.on('refresh_join_game')
def refresh_join_game():
    socketio.emit('refresh_join_game','', room="gamejoin")

@socketio.on('who_hasnt_written_name')
def who_hasnt_written_name(game_id,user_id=None):
    who_hasnt = header_zip_query(f"select user_id, username from user_instance where game_id = {game_id} and user_inst_id not in ( select user_inst_id from names where game_id = {game_id} )", multi = True)
    socketio.emit('who_hasnt_written_name', who_hasnt, room=f"user{user_id}" if user_id else f"game{game_id}")

@socketio.on('emit_current_turn')
def emit_current_turn(game_id,user_id=None):
    current_team_id, current_turn_user_id  = get_turn_order(game_id)
    socketio.emit('emit_current_turn', [current_team_id, current_turn_user_id], room=f"user{user_id}" if user_id else f"game{game_id}")
    socketio.emit('your_turn','', room=f"user{current_turn_user_id}")

@socketio.on('emit_next_name')
def emit_next_name(game_id,user_id):
    round = get_round(game_id)
    names = header_zip_query(f"select * from names where game_id = {game_id} and name_id not in (select name_id from answers where game_id = {game_id} and success=1 and round={round})",multi=True)
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

@socketio.on('advance_turn')
def advance_turn(game_id,user_id=None):
    advance_turn_order(game_id)
    emit_current_turn(game_id)
    #emit_current_round(game_id)

@socketio.on('advance_round')
def advance_round(game_id,user_id=None):
    advance_round_sql(game_id)
    emit_current_round(game_id,is_new_round=True)

@socketio.on('start_timer')
def start_timer(game_id):
    socketio.emit('start_timer', room=f"game{game_id}")

@socketio.on('stop_timer')
def stop_timer(game_id):
    socketio.emit('stop_timer',"", room=f"game{game_id}")

@socketio.on('score_answer')
def score_answer(game_id, user_id, name_id, success):
    user_inst_id = get_user_inst_id(user_id, game_id)
    round = get_round(game_id)
    name = query_sql(f"select name from names where name_id = {name_id}")[0][0]
    team_id = query_sql(f"select team_id from user_instance where user_inst_id={user_inst_id}")[0][0]
    query ="insert into answers (game_id, team_id, user_inst_id, name_id, name, success, round)"
    query += f"values ({game_id}, {team_id}, {user_inst_id}, {name_id}, '{name}', {success}, {round})"
    print(query)
    query_sql(query)

@socketio.on('get_mp3_number')
def get_mp3_number(user_id,start_or_stop):
    query = f"select number_{start_or_stop}s, current_{start_or_stop} from mp3_order"
    total, current = query_sql(query)[0]
    query_sql(f"update mp3_order set current_{start_or_stop}={(current+1)%total}")
    socketio.emit('get_mp3_number',{"mp3_number":current, "start_or_stop":start_or_stop}, room= f"user{user_id}")

@socketio.on('emit_scores')
def emit_scores(game_id,user_id,is_team=False):
    res = get_scores(game_id, is_team)
    socketio.emit('emit_scores',[res,is_team], room= f"user{user_id}")


# APP ROUTES

# homepage
@app.route('/', methods=["GET"])
def homepage():
    resp = make_response(render_template('homepage.html'))
    user_id = request.cookies.get('user_id')
    user_id, username = db_cookie(user_id)[0]
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
    first_round = ''
    for x in ['round1', 'round2', 'round3', 'round4']:
        if not first_round: first_round = int(x[-1])
        if x not in form.keys(): form[x]="0"
        elif form[x]=="on": form[x]="1"
    keys = ', '.join(form.keys())
    values = list(form.values())
    values = ', '.join([f"'{values[0]}'"]+values[1:])
    query = f"insert into games ({keys}, date_created, active, stage, round) values ({values}, NOW(), TRUE, 1,{first_round}); select game_id from games order by game_id desc limit 1"
    game_id = query_sql(query)[0][0]
    for i in range(int(form["number_teams"])):
        team_name = ''.join(random.choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(5))
        query2 = f"insert into teams (game_id,team_name) values ({game_id},'{team_name}')"
        query_sql(query2)
    refresh_join_game()
    return redirect(url_for('join_game'))


@app.route('/advance_game', methods=['POST'])
def advance_game():
    data = request.get_json()
    game_id, stage = data["game_id"], data["stage"]
    query_sql(f"update games set stage={stage} where game_id={game_id}")
    if stage == 3:
        if not turn_order_is_init(game_id): init_turn_order(game_id)
        for x in range(10):
            print("current turn order:", get_turn_order(game_id))
            advance_turn_order(game_id)
        print("final turn order:", get_turn_order(game_id))
    advance_game_emit(game_id)
    return make_response("",200)


@app.route('/join_game', defaults={'game_id': None})
@app.route('/join_game/<game_id>', methods=["GET"])
def join_game(game_id):    
    user_id = request.cookies.get('user_id')
    if not game_id:
        user_id, username = db_cookie(user_id)[0]
        games_sql = query_sql("select game_id, game_name from games where active=TRUE order by game_id desc")
        return render_template('join-game.html',games=games_sql,username=username)
    game_deets = get_game_deets(game_id)
    if game_deets["stage"] == 1:
        return redirect(url_for('lobby',game_id=game_id))
    elif query_sql(f"select user_inst_id from user_instance where game_id = {game_id} and user_id={user_id}"):
        if game_deets["stage"] == 2:
            return redirect(url_for('write_names',game_id=game_id))
        if game_deets["stage"] == 3:
            return redirect(url_for('name_game',game_id=game_id))
        if game_deets["stage"] == 4:
            return redirect(url_for('graphs',game_id=game_id))
    else: return redirect(url_for('join_game'))


#lobby
@app.route('/lobby/<game_id>', methods=["GET"])
def lobby(game_id):
    # TODO: if game has started, redirect to the started game
    game_deets = get_game_deets(game_id)
    user_id = request.cookies.get('user_id')
    username = request.cookies.get('username')
    db_user_instance(user_id,username,game_id)
    players = query_sql(f"select user_id, username from user_instance where game_id = {game_id}")
    teams = query_sql(f"select team_id, team_name from teams where game_id = {game_id}")
    user_inst_id = get_user_inst_id(user_id,game_id)
    emit_players(game_id)
    return render_template('lobby.html', game_id=game_id, game_deets=game_deets, username=username, players=players, teams=teams, user_inst_id=user_inst_id)


@app.route('/username_change', methods=["POST"])
def username_change():
    data = request.get_json()
    new_username, user_inst_id, game_id = data["new_username"], data["user_inst_id"], data["game_id"]
    user_id = request.cookies.get("user_id")
    print("new_username:",new_username,"user_id:",user_id)
    query_sql(f"update users set username='{new_username}' where user_id = {user_id}; update user_instance set username='{new_username}' where user_inst_id = {user_inst_id}")
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
    query_sql(f"update teams set team_name='{new_team_name}' where team_id = {team_id};")
    emit_teams(game_id)
    return make_response("",200)


@app.route('/player_team_change', methods=["POST"])
def player_team_change():
    data = request.get_json()
    user_id, team_id, game_id = data["user_id"], data["team_id"], data["game_id"]
    print("player_team_change:",user_id,"team_id:",team_id)
    query_sql(f"update user_instance set team_id='{team_id}' where user_id = {user_id} and game_id={game_id};")
    emit_players(game_id)
    return make_response("",200)


#write names
@app.route('/write_names/<game_id>', methods=["GET"])
def write_names(game_id):
    game_deets = get_game_deets(game_id)
    user_id = request.cookies.get('user_id')
    user_inst_id = get_user_inst_id(user_id,game_id)
    players = query_sql(f"select user_id, username from user_instance where game_id = {game_id}")
    return render_template('write-names.html', user_id=user_id, game_id=game_id, game_deets=game_deets, players=players, user_inst_id=user_inst_id)


@app.route('/submit_names', methods=["POST"])
def submit_names():
    data = request.get_json()
    user_id, game_id, names = data["user_id"], data["game_id"], data["names"]
    user_inst_id = get_user_inst_id(user_id,game_id)
    if not(query_sql(f"select name_id from names where user_inst_id={user_inst_id}")):
        query = "insert into names (user_inst_id,game_id,name) values"
        query += ",".join([f"({user_inst_id},{game_id},'{name}')" for name in names])
        query_sql(query)
        who_hasnt_written_name(game_id)
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
    teams = query_sql(f"select team_id, team_name from teams where game_id = {game_id}")
    players = query_sql(f"select user_id, username from user_instance where game_id = {game_id}")
    team_id = query_sql(f"select team_id from user_instance where user_inst_id = {user_inst_id}")[0][0]
    if game_deets['stage'] >= 4: return redirect(url_for(f"graphs", game_id=game_id))
    return render_template('name-game.html', user_id=user_id, game_id=game_id, game_deets=game_deets, players=players, username=username, user_inst_id=user_inst_id, teams=teams, team_id=team_id)


#graphs
@app.route('/graphs/<game_id>', methods=["GET"])
def graphs(game_id):
    user_id = request.cookies.get('user_id')
    game_deets = get_game_deets(game_id)
    round = query_sql(f"select round from answers where game_id = {game_id} order by round desc limit 1")[0][0]
    return render_template('graphs.html',game_id=game_id,user_id=user_id,round=round,game_deets=game_deets)



# START APP
if __name__ == '__main__':
    socketio.run(
        app,
        host="192.168.137.1",
        port=8, 
        log_output=True,
        debug=True
    ) # 192.168.0.106, port=8,