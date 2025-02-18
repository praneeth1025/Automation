import time 


from scripts.browser import Browser
from scripts.constants import BrowserConstants, ApplicantConstants


b = Browser()
BC = BrowserConstants()
AC = ApplicantConstants()

b.load_page(BC.url_jobs_linkedin)
b.get_element_by_wait('//*[@id="session_key"]').send_keys(AC.email_id)
b.get_element_by_wait('//*[@id="session_password"]').send_keys(AC.password)
time.sleep(2)
b.get_element_by_wait('//*[@id="main-content"]/section[1]/div/div/form/div[2]/button').click()
time.sleep(3)
b.get_element_by_wait('/html/body/div[6]/div[3]/div/div[3]/div/div/main/div/div/div[1]/div[1]/div/div/div/section/div[2]/a').click()
b.get_element_by_wait('/html/body/div[6]/div[3]/div[4]/section/div/div/nav/ul/li[2]/a').click()
all_jobs = b.get_element_by_wait('//*[@id="main"]/div/div[2]/div[1]/div/ul')