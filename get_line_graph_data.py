import psycopg2
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

game_id = 30
def get_line_graph_data(game_id, is_team=False):
    rounds = list(map(lambda x: x[0],query_sql(f"select distinct(round) from answers where game_id = {game_id} order by round")))
    #teams
    all_rounds_data = []
    for round in rounds:
        if is_team: data = query_sql(f"select t.team_name, count(*) from answers a join teams t on a.team_id = t.team_id where success = 1 and round = {round} and a.game_id = {game_id} group by t.team_name order by count(*) desc")
        else: data = query_sql(f"select u.username, count(*) from answers a join user_instance u on u.user_inst_id = a.user_inst_id where success = 1 and round = {round} and a.game_id = {game_id} group by u.username order by count(*) desc")
        all_rounds_data.append(data)
    dicti = {x:[] for x in [y[0] for y in all_rounds_data[0]]}
    dicti2 = {x:[] for x in [y[0] for y in all_rounds_data[0]]}
    for round in all_rounds_data:
        for player in round:
            dicti2[player[0]].append(player[1]+sum(dicti[player[0]]))
            dicti[player[0]].append(player[1])
    return({"cummulative":dicti2,"normal":dicti,"rounds":rounds})


print(get_line_graph_data(game_id, False))
print(get_line_graph_data(game_id, True))

# #HTML JS CODE FOR DISPLAYING THIS GRAPH - DRAFT
# <!DOCTYPE html>
# <html>
# <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
# <body>
# <canvas id="myChart" style="width:100%;max-width:600px"></canvas>

# <script>
# var xValues = ['round 1','round 2','round 3','round 4'];
# var colours = ['rgba(240,50,50,0.75)','rgba(255,180,50,0.75)','rgba(255,220,90,0.75)','rgba(100,210,80,0.75)','rgba(90,165,255,0.75)','rgba(170,90,240,0.75)']

# new Chart("myChart", {
#   type: "line",
#   data: {
#   	labels : xValues,
#     datasets: [{ 
#       label: 'michael',
#       data: [11, 15, 5, 12],
#       borderColor: colours[0],
#       fill: false
#     }, { 
#       label: 'mel',
#       data: [12, 5, 14, 13],
#       borderColor: colours[1],
#       fill: false
#     }, { 
#       label: 'Dev',
#       data: [13, 8, 10, 6],
#       borderColor: colours[2],
#       fill: false
#     }, { 
#       label: 'Tom',
#       data: [10, 8, 16, 16],
#       borderColor: colours[3],
#       fill: false
#     }, { 
#       label: 'Anna',
#       data: [9, 16, 8, 4],
#       borderColor: colours[4],
#       fill: false
#     }, { 
#       label: 'Jorge',
#       data: [5, 8, 7, 9],
#       borderColor: colours[5],
#       fill: false
#     }]
#   },
#   options: {
#     legend: {display: true},
#     scales: { yAxes: [{ticks: {min: 0}}] }
#   }
# });
# </script>



# <!DOCTYPE html>
# <html>
# <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
# <body>
# <canvas id="myChart" style="width:100%;max-width:600px"></canvas>

# <script>
# var xValues = ['round 1','round 2','round 3','round 4'];
# var colours = ['rgba(240,50,50,0.75)','rgba(255,180,50,0.75)','rgba(255,220,90,0.75)','rgba(100,210,80,0.75)','rgba(90,165,255,0.75)','rgba(170,90,240,0.75)']

# new Chart("myChart", {
#   type: "line",
#   data: {
#   	labels : xValues,
#     datasets: [{ 
#       label: 'michael',
#       data: [11, 26, 31, 43],
#       borderColor: colours[0],
#       fill: false
#     }, { 
#       label: 'mel',
#       data: [12, 17, 31, 44],
#       borderColor: colours[1],
#       fill: false
#     }, { 
#       label: 'Dev',
#       data: [13, 21, 31, 37],
#       borderColor: colours[2],
#       fill: false
#     }, { 
#       label: 'Tom',
#       data: [10, 18, 34, 50],
#       borderColor: colours[3],
#       fill: false
#     }, { 
#       label: 'Anna',
#       data: [9, 25, 33, 37],
#       borderColor: colours[4],
#       fill: false
#     }, { 
#       label: 'Jorge',
#       data: [5, 13, 20, 29],
#       borderColor: colours[5],
#       fill: false
#     }]
#   },
#   options: {
#     legend: {display: true},
#     scales: { yAxes: [{ticks: {min: 0}}] },
#     elements: {
#         line: {
#             tension: 0.1
#         }
#     }
#   }
# });
# </script>


