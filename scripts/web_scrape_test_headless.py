
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
import time,random,sys

def main(number_players=random.randint(3,14)):
    #VARIABLES
    #screen_offsets = (0,0)
    #screen_offsets = (2555, 0) #2x 4K
    screen_offsets = (2555, -720) #left2K right4K
    game_name = f"web_scrape_test_{datetime.now().strftime(r'%y-%m-%d_%H:%M:%S')}"
    game_id = None
    websitehome = "http://namegame.pw"
    # websitehome = "http://10.0.0.9:42069"
    # websitehome = "http://10.0.0.8:42069"
    names = ["Jasmine","Allan","Derick","Oscar","Rose","Megan","Elliot","Mary","Josh","Andy","Sarah"]*2
    nameCount = 3
    WindowCount = number_players
    teamCount = WindowCount//3
    timeLimit = 10


    #chrome setup
    chromedriver_autoinstaller.install()
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    # chrome_options.add_experimental_option("detach", True)
    chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
    #chrome_options.add_extension("C:/github_code/NameGame/scripts/extension_4_25_0_0.crx")
    windows = [webdriver.Chrome(options=chrome_options) for _ in range(WindowCount)]



    for w in range(WindowCount):
        d = windows[w]
        # home page
        d.get(websitehome)
        d.set_window_position(x=screen_offsets[0]+((w%7)*500),y=screen_offsets[1]+(w//7*1040))
        d.set_window_size(width=516, height=1040)

        # create game
        if w == 0:
            d.find_element(By.ID,'create_game').click()
            d.find_element(By.ID,'game_name').send_keys(game_name)
            d.execute_script(f"document.getElementById('number_teams').value = {teamCount}")
            d.execute_script(f"document.getElementById('number_names').value = {nameCount}")
            d.execute_script(f"document.getElementById('time_limit').value = {timeLimit}")
            d.find_element(By.ID,'create_game').click()

        # join game
        if w != 0: d.get(websitehome+f"/join_game")
        d.find_element(By.XPATH,f'.//*[@id="games"]/div/div[text()="{game_name}"]').click()# matching game option
        time.sleep(0.1)
        d.find_element(By.ID,'join_game').click()
        WebDriverWait(d, 0.6).until(EC.element_to_be_clickable((By.ID,'username_change')))
        d.find_element(By.ID,'username_change').clear()
        d.find_element(By.ID,'username_change').send_keys(f"{names[w]} {w}")

        #delete rainbow
        d.execute_script(f"document.getElementById('body').classList.remove('animate-rainbow')")

    #start game
    d.find_element(By.ID, 'shuffle').click()
    time.sleep(WindowCount* 0.1)
    d.find_element(By.ID, 'start_game').click()
    try:
        Alert(d).accept()
        time.sleep(0.8)
        d.find_element(By.ID, 'start_game').click()
    except: pass

    # write names
    d = windows[0]
    WebDriverWait(d, 40).until(EC.element_to_be_clickable((By.ID,'button0')))
    time.sleep(0.5)
    for w in range(WindowCount):
        d = windows[w]
        WebDriverWait(d, 0.6).until(EC.element_to_be_clickable((By.ID,'button0')))
        for n in range(nameCount):
            d.find_element(By.ID,f"button{n}").click() #click the dice
            time.sleep(0.02)
        d.find_element(By.ID, 'submit').click()
    time.sleep(nameCount* 0.1)
    d.find_element(By.ID, 'start_game').click()
        
    #name game
    time.sleep(1)
    while True:
        if "name_game" in d.current_url:
            try:
                string = ""
                for w in range(WindowCount):
                    d = windows[w]
                    if "-your" == d.find_element(By.ID,"body").get_attribute("class")[-5:]:
                    # string = d.find_element(By.XPATH, '/html/body/div/body/div[2]/h1[1]').text
                    # if string=="Your Turn": 
                        print(f"{w}'s turn",end=" ")
                        break
                if d.find_element(By.ID, 'start_button').get_attribute("disabled"):
                    #get a random integer and click a random number of times
                    randint = random.randint(0,7)
                    print(randint)
                    for _ in range(randint):
                        try: WebDriverWait(d, 0.6).until(EC.element_to_be_clickable((By.ID,'done_button')))
                        except: break
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
            for w in range(WindowCount):
                d = windows[w]
                try: 
                    if d.find_element(By.ID, "game_over").text == "GAME OVER":
                        exit = True
                        break
                except: pass
                try: 
                    print(d.find_element(By.ID, 'return_to_game').text)
                    for w in range(WindowCount):
                        d = windows[w]
                        d.find_element(By.ID, 'return_to_game').click()
                except: break
            if exit: break
                
    print("game_over")
    return 0
    # time.sleep(1000)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        num_players = int(sys.argv[1])
        a = main(num_players)
    else:
        a = main()
    sys.exit(a)