
#IMPORTS
import os
try: from selenium import webdriver
except: 
    os.system('cmd /c "pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org selenium"')
    from selenium import webdriver

try: import chromedriver_autoinstaller
except: 
    os.system('cmd /c "pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org chromedriver_autoinstaller"')
    import chromedriver_autoinstaller

from selenium.webdriver.common.alert import Alert
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait, Select
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from datetime import datetime
import time,random,sys#,argparse

def main(number_players=3,headless=False):
    #VARIABLES
    screen_offsets = (0,0)
    #screen_offsets = (2555, 0) #2x 4K
    #screen_offsets = (2555, -720) #left2K right4K
    game_name = f"web_scrape_test_{datetime.now().strftime(r'%y-%m-%d_%H:%M:%S')}"
    game_id = None
    websitehome = "http://namegame.pw"
    # websitehome = "http://10.0.0.9:42069"
    # websitehome = "http://10.0.0.8:42069"
    names = ["Jasmine","Allan","Derick","Oscar","Rose","Megan","Elliot","Mary","Josh","Andy","Sarah"]*2
    nameCount = 3
    windowCount = number_players
    teamCount = windowCount//3
    timeLimit = 10


    #chrome setup
    print(game_name)
    print(f"Setting up {windowCount} chrome windows")
    chromedriver_autoinstaller.install()
    chrome_options = Options()
    if headless: chrome_options.add_argument("--headless")
    # chrome_options.add_experimental_option("detach", True)
    chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
    # chrome_options.add_extension("C:/github_code/NameGame/scripts/old/extension_4_25_0_0.crx")
    windows = [webdriver.Chrome(options=chrome_options) for _ in range(windowCount)]



    for w in range(windowCount):
        d = windows[w]
        # home page
        print(f"Window {w} - homepage")
        d.get(websitehome)
        d.set_window_position(x=screen_offsets[0]+((w%7)*500),y=screen_offsets[1]+(w//7*1040))
        d.set_window_size(width=516, height=1040)

        # create game
        print(f"Window {w} - create_game")
        if w == 0:
            d.find_element(By.ID,'create_game').click()
            d.find_element(By.ID,'game_name').send_keys(game_name)
            d.execute_script(f"document.getElementById('number_teams').value = {teamCount}")
            d.execute_script(f"document.getElementById('number_names').value = {nameCount}")
            d.execute_script(f"document.getElementById('time_limit').value = {timeLimit}")
            d.find_element(By.ID,'create_game').click()

        # join game
        print(f"Window {w} - join_game")
        if w != 0: d.get(websitehome+f"/join_game")
        d.find_element(By.XPATH,f'.//*[@id="games"]/div/div[text()="{game_name}"]').click()# matching game option
        time.sleep(0.1)
        d.find_element(By.ID,'join_game').click()
        print(f"Window {w} - lobby")
        WebDriverWait(d, 0.6).until(EC.element_to_be_clickable((By.ID,'username_change')))
        d.find_element(By.ID,'username_change').clear()
        d.find_element(By.ID,'username_change').send_keys(f"{names[w]} {w}")
        d.find_element(By.ID,'username_change_button').click()

        #delete rainbow
        d.execute_script(f"document.getElementById('body').classList.remove('animate-rainbow')")

    #start game
    d.find_element(By.ID, 'shuffle').click()
    print(f"Window x - shuffle")
    try: WebDriverWait(d, windowCount*2).until(EC.element_to_be_clickable((By.ID,'start_game')))
    except: 
        d.get(+f"{websitehome}/join_game")
        WebDriverWait(d, windowCount*2).until(EC.element_to_be_clickable((By.ID,'start_game')))
    d.find_element(By.ID, 'start_game').click()
    print(f"Window x - start_game")
    try:
        Alert(d).accept()
        time.sleep(0.8)
        d.find_element(By.ID, 'start_game').click()
    except: pass

    # write names
    d = windows[0]
    WebDriverWait(d, 40).until(EC.element_to_be_clickable((By.ID,'button0')))
    time.sleep(0.5)
    for w in range(windowCount):
        print(f"Window {w} - write_names")
        d = windows[w]
        if "lobby" in d.current_url: 
            d.get(d.current_url.replace("lobby","write_names"))
            print(f"Window {w} - was stuck on lobby, now on write_names #########################################")
        WebDriverWait(d, 5).until(EC.element_to_be_clickable((By.ID,'button0')))
        for n in range(nameCount):
            d.find_element(By.ID,f"button{n}").click() #click the dice
            WebDriverWait(d, 5).until(lambda dr: dr.find_element(By.ID,f"name_input{n}").get_attribute("value") != "") #wait until element with ID f"name_input{n}" has value not equal to ""
        d.find_element(By.ID, 'submit').click()
    WebDriverWait(d, windowCount*nameCount*1).until(lambda dr: dr.find_element(By.ID,"waiting-on").text == 'Ready')
    d.find_element(By.ID, 'start_game').click()

    #cycle through windows if alert present
    # if EC.alert_is_present(d):
    #     for w in range(windowCount):
    #         d = windows[w]
    #         if EC.alert_is_present()(d): Alert(d).accept()
    #         if "lobby" in d.current_url:
    #             d.find_element(By.ID, 'start_game').click()
    #         else: 
    #             d.find_element(By.ID, 'submit').click()
    #     d.find_element(By.ID, 'start_game').click()

        
    #name game
    print(f"Window x - name_game")
    time.sleep(1)
    while True:
        if "name_game" in d.current_url:
            try:
                string = ""
                for w in range(windowCount):
                    d = windows[w]
                    if "-your" == d.find_element(By.ID,"body").get_attribute("class")[-5:]: break
                if d.find_element(By.ID, 'start_button').get_attribute("disabled"):
                    #get a random integer and click a random number of times
                    randint = random.randint(0,7)
                    print(f"{w}'s turn. {randint}")
                    for i in range(randint):
                        try: WebDriverWait(d, 0.6).until(EC.element_to_be_clickable((By.ID,'done_button')))
                        except: 
                            print(f"    ended early {i}")
                            try: WebDriverWait(d, 4).until(lambda dr: "graphs" in dr.current_url)
                            except: pass
                        d.find_element(By.ID,'done_button').click() #They got it
                try:
                    d.find_element(By.ID, 'concede_button').click() #End Button
                    time.sleep(0.1)
                except: continue
                try: 
                    WebDriverWait(d, 0.5).until(EC.element_to_be_clickable((By.ID, 'start_button')))
                    d.find_element(By.ID, 'start_button').click() #Start Button
                    WebDriverWait(d, 5).until(EC.element_to_be_clickable((By.ID, 'done_button')))
                except: continue
                
            except: continue
        else: 
            exit = False
            for w in range(windowCount):
                d = windows[w]
                try: 
                    if d.find_element(By.ID, "game_over").text == "GAME OVER":
                        exit = True
                        break
                except: pass
                try: 
                    print(d.find_element(By.ID, 'return_to_game').text)
                    for w in range(windowCount):
                        d = windows[w]
                        d.find_element(By.ID, 'return_to_game').click()
                except: break
            if exit: break
                
    print("game_over")
    return 0
    # time.sleep(1000)

if __name__ == "__main__":
#     parser = argparse.ArgumentParser()
#     parser.add_argument('-players','--players',type=int,help='number of players',default=10)
#     parser.add_argument('-names','--names',type=int,help='number of names',default=10)
#     parser.add_argument('-headless', action='store_true')
#     args = parser.parse_args()
#     print(args)
    headless = False
    if len(sys.argv) > 2:
        headless = sys.argv[2] == "--headless"
    if len(sys.argv) > 1:
        num_players = int(sys.argv[1])
        if num_players == 0: num_players = random.randint(3,9)
        a = main(num_players,headless)
    else:
        a = main()
        if a == 0: sys.exit(a)
        else: sys.exit(1)