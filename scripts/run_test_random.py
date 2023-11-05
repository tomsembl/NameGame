import os
while True:
    print("\n\nnum_players: random")
    a = os.system(r"C:\Users\TM3070Ti\GitHub\NameGame\scripts\web_scrape_test.py 0 --headless")
    print(a)
    with open(r"C:\Users\TM3070Ti\GitHub\NameGame\scripts\test_results.txt", "a") as file_object:
        file_object.write(str(a))