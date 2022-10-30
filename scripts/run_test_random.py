import os
while True:
    print("\n\nnum_players: random")
    a = os.system(r"C:\github_code\NameGame\scripts\web_scrape_test.py 0 --headless")
    print(a)
    with open(r"C:\github_code\NameGame\scripts\test_results.txt", "a") as file_object:
        file_object.write(str(a))