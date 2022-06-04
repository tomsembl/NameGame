import psycopg2
from datetime import datetime

def query_sql(query):
    try: conn = psycopg2.connect("dbname='namegame' user='postgres' host='localhost' password='masterpass2'")
    except: print("I am unable to connect to the database");return
    conn.autocommit = True
    cur = conn.cursor()
    cur.execute(query)
    #print(cur.fetchall())
    cur.close()
print("select user_id, username from user_instance where game_id =")
time = datetime.now()
query_sql('select * from games')
print("time elapsed", (datetime.now()-time).total_seconds())
time = datetime.now()
query_sql('select * from games')
print("time elapsed", (datetime.now()-time).total_seconds())
time = datetime.now()
query_sql('select * from games')
print("time elapsed", (datetime.now()-time).total_seconds())
#query_sql("""insert into games (game_name, number_teams, number_names, time_limit, round1, round4, round2, round3) values ('Insert Name Here', 3, 10, 60, 1, 1, 0, 0)""")
# try:
#     conn = psycopg2.connect("dbname='namegame' user='postgres' host='localhost' password='masterpass2'")
#     cur = conn.cursor()
#     cur.execute("""insert into games (game_name, number_teams, number_names, time_limit, round1, round4, round2, round3) values ('Insert Name Here', 3, 10, 60, 1, 1, 0, 0)""")
#     rows = cur.fetchall()
#     print(rows)
#     cur.close()
# except:
#     print("I am unable to connect to the database")