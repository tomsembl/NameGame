#software robot for downloading preceda leave report from website
#==============================================================================
#
#	Name:			Concur_Weekly_Uploads.py
#	Creation date:	11/08/2021
#  Author:			Tom McElhinney
#
#  Purpose:
#					This script (used every monday) will upload 3 files: default user settings, frequent travel programs and approval amounts from \\file.gt.local\sql$\Concur\Weekly Automated\
#                   
#                   ENSURE: 1. you have run the Concur_Weekly_Uploads.ps1 script (run from MGT05): 
#                              \\file.gt.local\sql$\Python and Powershell\Concur\Weekly_Uploads\Concur_Weekly_Uploads.ps1
#                              this script (↑) generates the 3 files that the current script (↓) uploads
#                           2. FIRST TIME SETUP:   I. you have installed Python
#                                                 II. you have installed the Selenium python module (cmd> pip install Selenium)
#                                                III. you have installed chromedriver to match your local chrome version at "DRIVER_PATH" below. 
#                                                         to find your chrome version, put this into chrome... chrome://settings/help
#                                                         to download chromedriver go to https://chromedriver.storage.googleapis.com/index.html
#	Changes:
#
#==============================================================================

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
import time



#VARIABLES
game_name = f"web_scrape_test_{time.time()}"
websitehome = "http://namegame.ddns.net:42069"
nameCount = 10
WindowCount = 5


#chrome setup
chromedriver_autoinstaller.install()
chrome_options = Options()
chrome_options.add_experimental_option("detach", True)
chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
#driver = webdriver.Chrome(options=chrome_options) #executable_path=DRIVER_PATH,
drivers = []

for w in range(WindowCount):
    drivers.append(webdriver.Chrome(options=chrome_options))
    # create game
    drivers[w].get(websitehome)
    drivers[w].set_window_size(width=515, height=1040)
    drivers[w].set_window_position(x=2560+(w*515),y=0)
    if w == 0:
        drivers[w].find_element(By.XPATH,'/html/body/button[1]').click()
        drivers[w].find_element(By.ID,'game_name').send_keys(game_name)
        drivers[w].find_element(By.XPATH,'/html/body/div/button[1]').click()

    # join game
    if w != 0: drivers[w].get(websitehome+"/join_game")
    drivers[w].find_element(By.XPATH,'/html/body/div[1]/div/div/div').click()
    drivers[w].find_element(By.XPATH,'/html/body/div[2]/button[1]').click()
    drivers[w].find_element(By.ID,'username_change').send_keys(f" {w}")
    drivers[w].find_element(By.XPATH, '/html/body/div[1]/h1/div/button').click()

#start game
drivers[0].find_element(By.XPATH, '/html/body/div[3]/div/h1[2]/div/button').click()
drivers[0].find_element(By.XPATH, '/html/body/div[5]/button[1]').click()
Alert(drivers[0]).accept()

# write names
for w in range(WindowCount):
    for n in range(nameCount):
        drivers[w].find_element(By.ID,f"button{n}").click()
    drivers[w].find_element(By.XPATH, '/html/body/div[2]/button[1]').click()
drivers[0].find_element(By.XPATH, '/html/body/div[2]/button[2]').click()
    
#name game

pass
# WebDriverWait(driver, 40).until(EC.element_to_be_clickable((By.ID,'toolsMenuIcon')))
# cogButton = driver.find_element(By.ID,'toolsMenuIcon')
# cogButton.click()

# # search menu for 'Extractor' and click it
# extractorElement = driver.find_element(By.ID,'menu-1104-targetEl').find_element(By.XPATH,"//a[./span[text() = 'Extractor']]")
# extractorElement.click()

# # click open
# openButton = driver.find_element(By.XPATH,"/html/body/div[@id='extractor']/div[2]/div[1]/div/div/div/div/div/div/div/a[3]") #driver.find_element(By.ID,'extractor').find_element(By.XPATH,"//div[contains(@id,'toolbar-') and contains(@id,'-innerCt')]")
# #WebDriverWait(driver, 40).until(EC.element_to_be_clickable(openButton))
# openButton.click()

# # search table for "LEAVE HISTORY REPORT" and click it
# time.sleep(2)
# driver.find_element(By.XPATH,"/html/body/div[contains(@id,'ext-comp-')]//div[contains(@id,'tableview-')]").send_keys("m")
# tableElement = driver.find_element(By.XPATH,"/html/body/div[contains(@id,'ext-comp-')]//div[contains(@id,'tableview-')]//div[text() = 'LEAVE HISTORY RPT']")
# tableElement.click()

# # click OK
# okButton = driver.find_element(By.XPATH,"/html/body/div[contains(@id,'ext-comp-')]//div[contains(@id,'-bodyWrap')]/div[contains(@id,'toolbar')]/div/div/a[1]")
# okButton.click()

# # search table for "Leave History.Leave Start Date" and click it
# time.sleep(2)
# tableElement2 = driver.find_element(By.XPATH,"//div[text() = 'Leave History.Leave Start Date']")
# tableElement2.click()

# # change leave start date
# dateInput = driver.find_elements(By.XPATH,"/html/body/div[@id='extractor']//input[contains(@id,'ngadatefield-') and contains(@id,'-inputEl')]")[1]
# dateInput.clear()
# dateInput.send_keys('01/05/2022')


# # run
# runButton = driver.find_element(By.XPATH,"/html/body/div[@id='extractor']/div[2]/div[1]/div/div/div/div/div/div/div/a[5]")
# runButton.click()

# # click ok
# WebDriverWait(driver, 40).until(EC.element_to_be_clickable((By.XPATH,"/html/body/div[contains(@id,'ext-comp-')][2]")))
# okButton2 = driver.find_element(By.XPATH,"/html/body/div[contains(@id,'ext-comp-')][2]/div[contains(@id,'-bodyWrap')]/div[contains(@id,'toolbar')]/div/div/a[1]")
# okButton2.click()

# # click ok
# WebDriverWait(driver, 40).until(EC.element_to_be_clickable((By.XPATH,"/html/body/div[contains(@id,'ext-comp-')][3]")))
# okButton3 = driver.find_element(By.XPATH,"/html/body/div[contains(@id,'ext-comp-')][3]/div[contains(@id,'-bodyWrap')]/div[contains(@id,'toolbar')]/div/div/a[1]")
# okButton3.click()






time.sleep(1000)
