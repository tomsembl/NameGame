
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
import time,random

def getGameName(): return f"web_scrape_test_{datetime.now().strftime(r'%y-%m-%d_%H:%M:%S')}"

#VARIABLES
game_name = getGameName()
game_id = None
# websitehome = "http://namegame.ddns.net:42069"
websitehome = "http://192.168.0.113:42069"
# websitehome = "http://192.168.0.106:8"
nameCount = 4
WindowCount = 4
teamCount = WindowCount//2
timeLimit = 1


#chrome setup
chromedriver_autoinstaller.install()
chrome_options = Options()
# chrome_options.add_experimental_option("detach", True)
chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
windows = [webdriver.Chrome(options=chrome_options) for _ in range(WindowCount)]



for w in range(WindowCount):
    d = windows[w]
    # home page
    d.get(websitehome)
    d.set_window_position(x=2555+((w%7)*500),y=-720+(w//7*1040))
    d.set_window_size(width=516, height=1040)
    # create game
    if w == 0:
        d.find_element(By.XPATH,'/html/body/button[1]').click()
        d.find_element(By.ID,'game_name').send_keys(game_name)
        d.execute_script(f"document.getElementById('number_teams').value = {teamCount}")
        d.execute_script(f"document.getElementById('number_names').value = {nameCount}")
        d.execute_script(f"document.getElementById('time_limit').value = {timeLimit}")
        d.find_element(By.XPATH,'/html/body/div/button[1]').click()

    # join game
    if w != 0: d.get(websitehome+f"/join_game")
    d.find_element(By.XPATH,f'.//*[@id="games"]/div/div[text()="{game_name}"]').click()# matching game option
    
    d.find_element(By.XPATH,'/html/body/div/div[2]/button[1]').click()#join game button
    d.find_element(By.ID,'username_change').send_keys(f" {w}")
    d.find_element(By.XPATH, '/html/body/div[1]/h1/div/button').click()

#start game
d.find_element(By.XPATH, '/html/body/div[3]/div/h1[2]/div/button').click()
time.sleep(0.5)
d.find_element(By.XPATH, '/html/body/div[5]/button[1]').click()
Alert(d).accept()

# write names
# WebDriverWait(d, 40).until(EC.element_to_be_clickable((By.ID,'button0')))
time.sleep(0.5)
for w in range(WindowCount):
    d = windows[w]
    for n in range(nameCount):
        d.find_element(By.ID,f"button{n}").click()
        #time.sleep(0.1)
    d.find_element(By.XPATH, '/html/body/div[2]/button[1]').click()
time.sleep(0.1)
d.find_element(By.XPATH, '/html/body/div[2]/button[2]').click()
    
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
                    print(f"{w}'s turn")
                    break
            if d.find_element(By.ID, 'start_button').get_attribute("disabled"):
                #get a random integer and click a random number of times
                for _ in range(random.randint(0,7)):
                    try: WebDriverWait(d, 0.5).until(EC.element_to_be_clickable((By.XPATH,'/html/body/div/body/div[2]/button')))
                    except: break
                    d.find_element(By.XPATH, '/html/body/div/body/div[2]/button').click() #They got it
            try: 
                WebDriverWait(d, 0.5).until(EC.element_to_be_clickable((By.ID, 'start_button')))
                d.find_element(By.ID, 'start_button').click() #Start Button
            except: continue
            try:
                d.find_element(By.ID, 'concede_button').click() #End Button
                time.sleep(0.1)
            except: continue
        except: continue
    else: 
        for w in range(WindowCount):
            d = windows[w]
            try: 
                if d.find_element(By.XPATH, ".//*[@text='GAME OVER']"): break
            except: pass
            try: d.find_element(By.XPATH, '/html/body/div[3]/button').click()
            except: break
print("game_over")
pass

time.sleep(1000)
