from selenium import webdriver

driver = webdriver.Chrome()
driver.get("https://www.linkedin.com/login")

print("Title" , driver.title)
