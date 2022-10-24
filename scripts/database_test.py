
import sqlite3
from os.path import join, dirname, abspath

db_path = join(dirname(abspath(__file__)), 'namegame.db')
conn = sqlite3.connect(db_path, check_same_thread=False, isolation_level=None)
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
for g in range(1,4):
    for r in range(1,5):
        for x in range(1,7):
    
            #print no new line
            print(g,r,x,end="")
            try:
                print(q_sql(f"select turn_id, time_start from turns where user_inst_id = :user_inst_id and game_id = :game_id and round = :round order by turn_id desc limit 1",{'user_inst_id':x,'game_id':g,'round':r})[0])

            except IndexError: print("fail")
