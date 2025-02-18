## Global Imports
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

## Local Imports


## Constants
WAIT_SEC = 10


## Classes and Functions
class Browser:
    def __init__(self):
        options = Options()
        options.add_experimental_option('detach', True)
        options.add_argument('--window-size=1600,960')
        options.add_argument('--disable-notifications')
        self.driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

    def load_page(self, page_url:str):
        self.driver.get(page_url)

    def get_element_by_wait(self, xpath:str, wait_sec:int=WAIT_SEC):
        return WebDriverWait(self.driver, wait_sec).until(EC.presence_of_element_located((By.XPATH, xpath)))
    
    def click_nwait(self, element, wait_sec:int=WAIT_SEC):
        element.click()
        time.sleep(wait_sec)

