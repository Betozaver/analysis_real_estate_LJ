-- Cleaning csv files from GURS for year 2015
-----------------------------------------------------------------------------------------
-- 13/7/2024

--count of rows:
SELECT COUNT(*) FROM gurs.main.stavbe_2015;

--- WE CHANGED DIRECTION:
-- We have flitered the data by obcina, so we only get LJ, 
-- then we choosed building that are for living, 
-- and we filtered them by 'stanovanje' type
CREATE TABLE gurs.main.clean_stavbe_2016 AS
SELECT *
  FROM gurs.main.stavbe_2016
 WHERE OBCINA = 'LJUBLJANA'
   AND (VRSTA_DELA_STAVBE = 1 OR VRSTA_DELA_STAVBE = 2)
   AND LOWER(DEJANSKA_RABA_DELA_STAVBE) LIKE '%stanovanje%';


-- table deli_stavb has a lot of columns that are not needed for price prediction
-- MAKING A NEW TABLE clean_stavbe_2016
CREATE TABLE clean_stavbe_2016_1 AS
SELECT ID_POSLA, SIFRA_KO, IME_KO, OBCINA, STEVILKA_STAVBE, STEVILKA_DELA_STAVBE, 
	NASELJE, ULICA, HISNA_STEVILKA, STEVILKA_STANOVANJA_ALI_POSLOVNEGA_PROSTORA, VRSTA_DELA_STAVBE,
	LETO_IZGRADNJE_DELA_STAVBE, STAVBA_JE_DOKONCANA, GRADBENA_FAZA, NOVOGRADNJA, PRODANA_POVRSINA, 
	PRODANI_DELEZ_DELA_STAVBE, NADSTROPJE_DELA_STAVBE, DEJANSKA_RABA_DELA_STAVBE, POVRSINA_DELA_STAVBE, 
	UPORABNA_POVRSINA, LETO
FROM clean_stavbe_2016;

-- GROUPBY SO WE CAN GET UNIQUE ENTRIES FOR APARTMENTS AND BUILDINGS
-- this code is only for some other database..ignore it
CREATE TABLE stavbe_gurs_2015 AS
SELECT * from clean_stavbe_2015_202507211330
GROUP by STEVILKA_STAVBE, STEVILKA_DELA_STAVBE;
---331 matches.

---deleting the entries that have a NULL in size
DELETE FROM gurs.main.clean_stavbe_2015_1 
WHERE POVRSINA_DELA_STAVBE IS NULL;

--- another step where we check the data. In 2014 .csv files, 
---there are some entries that are multiplied,
--- but in table of posli, there is only one entry for each transaction.
select count(ID_POSLA), ID_POSLA from gurs.main.clean_stavbe_2015
GROUP BY ID_POSLA
ORDER BY COUNT(ID_POSLA) DESC;



--- cheking how many entries have same ID_POSLA
SELECT COUNT(*) AS rows_to_delete
  FROM gurs.main.clean_stavbe_2015_1 cs  c 
 WHERE ID_POSLA IN (
   SELECT ID_POSLA
     FROM gurs.main.clean_stavbe_2015_1 c2 
    GROUP BY ID_POSLA
   HAVING COUNT(*) > 1
   );

-- deleting them
DELETE FROM gurs.main.clean_stavbe_2015_1 
 WHERE ID_POSLA IN (
   SELECT ID_POSLA
     FROM gurs.main.clean_stavbe_2015_1 c 
    GROUP BY ID_POSLA
   HAVING COUNT(*) > 1
 );

--- create a new clean table clean_posli_2015
CREATE TABLE new_posli_2015 AS
SELECT ID_POSLA, VRSTA_KUPOPRODAJNEGA_POSLA, POGODBENA_CENA_ODSKODNINA, OBCINA, 
       SIFRA_KO, IME_KO, STEVILKA_STAVBE, STEVILKA_DELA_STAVBE, NASELJE, ULICA, HISNA_STEVILKA
FROM gurs.main.posli_2015;

---this step is not needed
--- deleting the entries that are not a sale
DELETE FROM gurs.main.new_posli_2015 
WHERE VRSTA_KUPOPRODAJNEGA_POSLA <> 1;

---merging the clean_stavbe_2014 table with posli table, to get the price of each apartment
create table prodaja2015 AS
from gurs.main.clean_stavbe_2015 as d
INNER JOIN gurs.main.posli_2015 AS a
ON d.ID_POSLA = a.ID_POSLA

---making a new table with only the columns we need for visualization and machine learning
CREATE TABLE new_prodaja2014 AS
SELECT ID_POSLA, IME_KO, NASELJE, LETO_IZGRADNJE_DELA_STAVBE,
	POVRSINA_DELA_STAVBE, LETO, POGODBENA_CENA_ODSKODNINA FROM gurs.main.prodaja2014;
  


 --- .csv is ready for machine learning and data visualization