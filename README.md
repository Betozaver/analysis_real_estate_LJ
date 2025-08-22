# analysis_real_estate_LJ
Historical analysis of real estate market, price forcasting using data sourced from GURS (https://www.e-prostor.gov.si/) and scrape from nepremicnine.net in July 2025.

ABOUT THE PROJECT:
In front of you is my individual project, where I'm analysing prices in Ljubljana municipality, Slovenia. My data source is based on public data provided and collected by GURS - Geodetska uprava Republike Slovenije (eng. Geodetic Administration of the Republic of Slovenia). I have choose a period of 11 years, from 2014 to 2024 (due to even more missing and inconsistent entering of values in previous years) to show how trend of prices in Ljubljana city and nearby area is rapidly changing, hoping to uncover what factors make a real-estate more expensive. I was considering total size of apartment/house, district (in Ljubljana) and newness of the building.
Reason to do this project is strictly personal, since I'm hoping to become a homeowner one day, and only thrust-worthy source of real estate information in Slovenia is GURS. 
After poking through high volume of data, I have been left with 30k+ rows of data which after modeling shone a light to what It seems a different price points entries of real-estate market, which was never discussed in GURS reports, quietly skewing data (median of price) but never properly disclosed. I would dare to say, that this kind of non disclosure is shaping Ljubljana real-estate market more than we dare to think.
 All of the data was cleaned and sorted, in front of you is a cleaned and cut data set, with price ranges from second and third quartiles. All extremes were cut, since low extremes did not show any impact when modeled, but as I stated, luxury market has a strong hold on median and is skewing data, which disables us to get a real price per square meter for middle and 'superior' (op. higher) priced range of real estate in Ljubljana municipality. 
Since year of 2025 is not over yet, I have scraped actual listings on website nepremicnine.net using selenium driver, to have a sneak peak of rise of prices from last year to this. 
This project is not completed, I'm still working on last part, which is machine learning prediction of prices, only based on characteristics of the buildings, part of the town and year of build. Other social implications are not considered (politics, financial markets, etc.), but prices will surely rise.
Project has a few pages. On first page we have market overview, following location focus, current market snapshot and finishing with deep dive and exploration of some of the real estate characteristics.

A DISCLAIMER: GURS data sets were perplexing, bewildering, baffling, mystifying, mind-boggling, and incomprehensible with a lot of NULL, zero values, as also wrongly placed values, which means in data analyzing world: bad data. For each year, I had to merge two data sets (so 22 .csv files), one file with sales prices and one with just data specifications of real-estate units. There was a gapping inconsistency in entering data, since each sold unit, had a unique ID_posla (ID_job), or so I thought. There were more than a couple thousands units (in some years even more than 300+, usually new developments), sold under same ID_posla, with one random price in the other file with prices. So, all in all, numbers about TOTAL sold units are not correct, but with all of the error values and cut luxury units, we have here a "FEELING" what prices might be/are.
This was a practice project, which tested my nerves and sanity. Enjoy!

HOW TO, STEP BY STEP:

Getting same results, step by step. 
First go ahead and download .csv files from upper link. There is four .csv files for each year, I used _DELISTAVB_ and _POSLI_ for each year. I would highly recommend you to carefully read through document sifranti.pdf, which I have found randomly on internet and is about this particular data. 

- This step was done in DBeaver with DuckDB driver. Load .csv in DBeaver. My complete SQL code is written in file sql, containing another file with notes. 

- I have loaded all of my cleaned .csv files in clean_GURS file from DBeaver. 
- I have looked through my cleaned data in VSCode, you can find jupyter notebooks in vscode_cleaning file. This was used only to look, do a modeling of data, graphs and most important boxplots and such. All of the boxplots are saved in power_bi_ready file -> gurs_cut for each year. 

- Did an ultimative clean and cut with 02_gurs_ultimate_cleaning_all, with this jupyter notebook I have cut extreme values and have prepered my data for visualization in Power BI. Prepped data was saved in power_bi_ready file. 

- I need a couple tries, especially with dots and commas conundrum, since Slovenia has a different system for number values... dots_to_commas_GURS.ipynb file contains code to concate all of the .csv for each year and also it sorts out dots and commas dilema. 

- scrape of nepremicnine.net, I have my scrape in .ipynb file, you can go ahead and do it as .py it is easier. All the code is in nepremicnine_scrape file. Go ahead and do files from 01 to 04. I did looked through the data in 02_preparing.. also, 04 was modeling of the data. 05_cadastral_problems.ipynb was part of maps that I did in Power BI as Shape Map visualization.

- Power Bi steps: load all of the cleaned and cut data. 
- Power BI shape map: it needs topo_json. Find original sized file ko.geojson, it shows whole Slovenia. 
    - Next step was to load geojson in vscode and find all cadastre municipalities in Ljubljana. After I got the list, I have merged it with one of the older versions of my cleaned and cut data. Droped ID and did the same thing for nepremicnine. Important part is that eventhough we are maching on numbers, in Power BI is mactched on names. So each entry should have right cadastre name. After that I would recommend to cut geojson to only entries that are for Ljubljana municipality. All done in same file cadastre_join.ipynb. Also, there was a lot of work to unify names, so that all was done by hand.

- to transform geojson to topojson I have used https://mapshaper.org/, mapshaper. Good luck! File should be small enough no to disrupt Power BI process. I honestly don't know how I managed all of this, my memory is blank. Just trauma.

- Load this beutifully small topojson in Power BI, and make a lovely Ljubljana map which is interactive. 

- Do visualizations. My finished report: https://app.powerbi.com/view?r=eyJrIjoiYWMyODk2ZTgtOGIzNy00OTE2LWE2NmQtZTVjMDEyYWQwMjBjIiwidCI6IjAwNjNhZmMzLWU2OGUtNDFjOC05M2QzLTBkMjNkOWI5NTk1NiIsImMiOjl9&pageName=c12c629000018899d949&pageName=c12c629000018899d949






    