🏡 Historical Analysis of the Ljubljana Real Estate Market

   Price Forecasting with GURS & Nepremicnine.net Data (2014–2025)
   
   This project analyzes real estate prices in Ljubljana, Slovenia, using data from:
   
   GURS – Geodetska uprava Republike Slovenije ([official source](https://www.e-prostor.gov.si/)
   )
   
   Nepremicnine.net (scraped in July 2025)
   
   The goal is to understand long-term price trends (2014–2024) and build a machine learning model for forecasting prices, using only property characteristics (size, location, year built, etc.).

   FIND MY REPORT: 📊 View the interactive dashboard:([my report](https://app.powerbi.com/view?r=eyJrIjoiYWMyODk2ZTgtOGIzNy00OTE2LWE2NmQtZTVjMDEyYWQwMjBjIiwidCI6IjAwNjNhZmMzLWU2OGUtNDFjOC05M2QzLTBkMjNkOWI5NTk1NiIsImMiOjl9&pageName=c12c629000018899d949&pageName=c12c629000018899d949))

📖 About the Project

   This is an individual project focused on Ljubljana’s real estate market.
   
   Data timeframe: 2014–2024 (11 years). Earlier data was excluded due to missing and inconsistent entries.
   
   Motivation: Personal. As a prospective homeowner, I wanted reliable insights into price evolution.
   
   Factors considered:
   
   Size of apartment/house
   
   District (within Ljubljana)
   
   Year of construction (newness of building)
   
   Data volume: 30k+ rows after cleaning.
   
   Challenges: GURS data is inconsistent, often incomplete, and skewed by luxury properties. Median values are heavily influenced by high-end sales, obscuring the “real” market for mid-range buyers.
   
   Since 2025 isn’t complete, I additionally scraped live listings from Nepremicnine.net for a snapshot of current market conditions.
   
   ⚠️ Note: This project excludes broader social/economic factors (politics, financial markets, etc.). It focuses strictly on property features and transactions.

⚡ Key Insights

   Luxury properties significantly skew official medians.
   
   Removing outliers reveals different price dynamics for middle and “superior” (higher) price ranges.
   
   Data cleaning was intensive: null values, wrong placements, duplicate IDs (ID_posla) — some projects had 300+ sales recorded under a single ID with one random price.
   
   Final dataset offers a more realistic view of real prices per m² for everyday buyers.

🛠️ Workflow & Files
   1. Data Collection
   
      CSV files from GURS: 22 files (sales + specifications, yearly).
      
      Important reference: sifranti.pdf – essential for understanding data codes.
      
      Scraping Nepremicnine.net: nepremicnine_scrape folder (01 → 04 steps).
   
   2. Cleaning & Preparation
   
      SQL scripts → see sql/ (executed in DBeaver + DuckDB).
      
      Cleaned files saved in clean_GURS/.
      
      Jupyter notebooks for exploration → vscode_cleaning/.
      
      Handling Slovenia’s decimal separator issue: dots_to_commas_GURS.ipynb.
      
      Final clean cut → 02_gurs_ultimate_cleaning_all.ipynb → data exported to power_bi_ready/.
   
   3. Modeling & Exploration
   
      Exploratory data analysis with boxplots & graphs.
      
      Outliers removed → dataset restricted to Q2–Q3 price ranges.
      
      Additional cadastral mapping → 05_cadastral_problems.ipynb.
   
   4. Visualization
     
      Power BI report → 📊 View the interactive dashboard:([my report](https://app.powerbi.com/view?r=eyJrIjoiYWMyODk2ZTgtOGIzNy00OTE2LWE2NmQtZTVjMDEyYWQwMjBjIiwidCI6IjAwNjNhZmMzLWU2OGUtNDFjOC05M2QzLTBkMjNkOWI5NTk1NiIsImMiOjl9&pageName=c12c629000018899d949&pageName=c12c629000018899d949))
      
      Shape maps:
      
      GeoJSON (ko.geojson) → converted to TopoJSON with MapShaper.
      
      Cadastral joins handled in cadastre_join.ipynb.

🚧 Work in Progress

   🔮 Machine learning forecasting: under development.
   
   Currently building predictive models using XGBoost with features like:
   
   Location (district/cadastral area)
   
   Size of unit
   
   Year built

⚠️ Disclaimer

   GURS datasets are messy, inconsistent, and incomplete. Many values were null, zero, or misplaced. This project involved extensive cleaning, merging, and manual validation.
   
   This is a practice project, done to test my data engineering and analysis skills — and my patience.
   Consider results as directional insights, not official statistics.

📂 File/Folder Guide

   sql/ → SQL scripts (DuckDB in DBeaver)
   
   clean_GURS/ → all cleaned CSVs
   
   vscode_cleaning/ → exploratory notebooks (graphs, boxplots)
   
   power_bi_ready/ → processed datasets ready for BI
   
   nepremicnine_scrape/ → scraping workflow (steps 01 → 04)
   
   dots_to_commas_GURS.ipynb → decimal cleanup
   
   02_gurs_ultimate_cleaning_all.ipynb → final preprocessing
   
   cadastre_join.ipynb → cadastral name harmonization
   
   05_cadastral_problems.ipynb → map preparation for Power BI
   ([geojson slovenia](https://github.com/sebenik/toposi/blob/master/OB/obcine.geojson))

🎯 Final Thoughts

   This project exposed how luxury listings distort official reports, creating a misleading picture of affordability in Ljubljana. By cleaning and restructuring the data, we get a truer picture of the mid-range market.
   
   While not yet complete, this work lays the foundation for robust price forecasting models — and hopefully, a more transparent view of Slovenia’s real estate market.








    
