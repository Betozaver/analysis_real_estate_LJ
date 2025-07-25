pip install undetected-chromedriver
import undetected_chromedriver as uc
from selenium.webdriver.common.by import By
#from tabulate import tabulate
import csv
import time
import random

def scrape_nepremicnine_stanovanja():
    base_url = "https://www.nepremicnine.net/oglasi-prodaja/ljubljana-mesto/stanovanje"
    headers = ["NASLOV", "CENA", "OPIS", "m2", "LETO", "NASTROPJE", "ZEMLJISCE"]
    data = []

    driver = uc.Chrome()
    # when you go to the URL click the show last page and enter the number +1 (so if its page 34 enter 35)
    for page in range(1, 4):  # pages 1 to 34 inclusive
        if page == 1:
            url = base_url + "/"
        else:
            url = f"{base_url}/{page}/"

        print(f"Scraping page {page}...")
        driver.get(url)

        time.sleep(random.uniform(5, 8))  # wait like a human

        ads = driver.find_elements(By.CLASS_NAME, "property-details")

        for ad in ads:
            try:
                naslov = ad.find_element(By.CLASS_NAME, "url-title-d").text
                price = ad.find_element(By.TAG_NAME, "h6").text
                description = ad.find_element(By.TAG_NAME, "p").text
                ul = ad.find_element(By.TAG_NAME, "ul")
                lis = ul.find_elements(By.TAG_NAME, "li")
                m2 = leto = nastropje = zemljisce = "N/A"
                for li in lis:
                    try:
                        img = li.find_element(By.TAG_NAME, "img")
                        src = img.get_attribute("src")
                        value = li.text.strip()

                        if "velikost.svg" in src:
                            m2 = value
                        elif "leto.svg" in src:
                            leto = value
                        elif "nadstropje.svg" in src:
                            nastropje = value
                        elif "zemljisce.svg" in src:
                            zemljisce = value
                    except:
                        continue
                data.append([naslov, price, description, m2, leto, nastropje, zemljisce])
            except:
                continue

    driver.quit()

    with open("stanovanja.csv", "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f, delimiter=';')
        writer.writerow(headers)  # Write header row
        writer.writerows(data)    # Write all data rows

    print("✅ Data exported to stanovanja.csv")

def scrape_nepremicnine_hisa():
    base_url = "https://www.nepremicnine.net/oglasi-prodaja/ljubljana-mesto/hisa"
    headers = ["NASLOV", "CENA", "OPIS", "m2", "LETO", "NASTROPJE", "ZEMLJISCE"]
    data = []

    driver = uc.Chrome()
    # when you go to the URL click the show last page and enter the number +1 (so if its page 34 enter 35)
    for page in range(1, 3):  # pages 1 to 34 inclusive
        if page == 1:
            url = base_url + "/"
        else:
            url = f"{base_url}/{page}/"

        print(f"Scraping page {page}...")
        driver.get(url)

        time.sleep(random.uniform(5, 8))  # wait like a human

        ads = driver.find_elements(By.CLASS_NAME, "property-details")

        for ad in ads:
            try:
                naslov = ad.find_element(By.CLASS_NAME, "url-title-d").text
                price = ad.find_element(By.TAG_NAME, "h6").text
                description = ad.find_element(By.TAG_NAME, "p").text
                ul = ad.find_element(By.TAG_NAME, "ul")
                lis = ul.find_elements(By.TAG_NAME, "li")
                m2 = leto = nastropje = zemljisce = "N/A"
                for li in lis:
                    try:
                        img = li.find_element(By.TAG_NAME, "img")
                        src = img.get_attribute("src")
                        value = li.text.strip()

                        if "velikost.svg" in src:
                            m2 = value
                        elif "leto.svg" in src:
                            leto = value
                        elif "nadstropje.svg" in src:
                            nastropje = value
                        elif "zemljisce.svg" in src:
                            zemljisce = value
                    except:
                        continue
                data.append([naslov, price, description, m2, leto, nastropje, zemljisce])
            except:
                continue

    driver.quit()

    with open("hise.csv", "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f, delimiter=';')
        writer.writerow(headers)  # Write header row
        writer.writerows(data)    # Write all data rows

    print("✅ Data exported to hise.csv")


scrape_nepremicnine_stanovanja()
scrape_nepremicnine_hisa()
