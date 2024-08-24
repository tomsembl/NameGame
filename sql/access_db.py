import sqlite3
from os.path import join, dirname, abspath

db_path = join(dirname(dirname(abspath(__file__))), 'namegame.db')
conn = sqlite3.connect(db_path, check_same_thread=False, isolation_level=None)

def q_sql(query,data=False,get_header=False):
    cur = conn.cursor()
    if data: cur.execute(query,data)
    else: 
        try:
            cur.execute(query)
        except sqlite3.OperationalError as e:
            cur.execute("rollback")
            print("error:",e)
    output = ""
    try: 
        output = cur.fetchall()
        if get_header: output = [[i[0] for i in cur.description],output]
    except: pass
    finally:
        cur.close()
        return output
    
print(q_sql("select * from teams limit 1"))