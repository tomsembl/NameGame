import os
import web_scrape_test
#get current directory
dir = os.path.dirname(os.path.realpath(__file__))
while True:
    print("\n\nnum_players: random")
    #a = os.system(f"{dir}/web_scrape_test.py 0 --headless")
    a = web_scrape_test.main(3, True)
    print(a)
    with open(f"{dir}/test_results.txt", "a") as file_object:
        file_object.write(str(a))