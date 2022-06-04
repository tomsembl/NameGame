from logging import error
import psycopg2
from datetime import datetime

try: conn = psycopg2.connect("dbname='namegame' user='postgres' host='localhost' password='masterpass2'")
except: raise( error,"I am unable to connect to the database")
conn.autocommit = True

def query_sql(query):
    cur = conn.cursor()
    cur.execute(query)
    print(cur.fetchall())
    cur.close()
print("fast test")
time = datetime.now()
query_sql('select * from test')
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