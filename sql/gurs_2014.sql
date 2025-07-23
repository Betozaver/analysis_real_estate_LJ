-- Cleaning csv files from GURS for year 2014
-- this steps are applicable for all years, but I will only use 2014 data



-- droping entries that are not in Ljubljana
DELETE FROM gurs.main.zamljisca
WHERE OBCINA <> 'LJUBLJANA'

DELETE FROM gurs.main.deli_stavb 
WHERE OBCINA <> 'LJUBLJANA'

-- cleaning the zemljisca table, looking through the entries.
ALTER TABLE gurs.main.zamljisca DROP COLUMN OPOMBE_O_NEPREMICNINI
ALTER TABLE gurs.main.zamljisca DROP COLUMN N_CENTROID
ALTER TABLE gurs.main.zamljisca  DROP COLUMN LETO
ALTER TABLE gurs.main.zamljisca  DROP COLUMN VRSTA_TRAJNEGA_NASADA
ALTER TABLE gurs.main.zamljisca  DROP COLUMN STAROST_TRAJNEGA_NASADA
ALTER TABLE gurs.main.zamljisca  DROP COLUMN PRODANI_DELEZ_PARCELE
ALTER TABLE gurs.main.zamljisca  DROP COLUMN POGODBENA_CENA_PARCELE
ALTER TABLE gurs.main.zamljisca  DROP COLUMN STOPNJA_DDV_PARCELE
ALTER TABLE gurs.main.zamljisca  DROP COLUMN E_CENTROID


-- cleaning the zemljisca table, including entries of plots, that were sold as part of a house
DELETE FROM gurs.main.zamljisca 
WHERE VRSTA_ZEMLJISCA <> 5

-- cleaning the zemljisca table, including only the needed columns
CREATE TABLE zemljisca14 AS SELECT DISTINCT PARCELNA_STEVILKA, 
ID_POSLA, SIFRA_KO, IME_KO, VRSTA_ZEMLJISCA, POVRSINA_PARCELE
FROM gurs.main.zamljisca

-- for zamljisca table, I only need the ID_POSLA (which is the transaction ID) and sum of area sold.
-- some of ID_POSLA are repeated, since some of the plots sold were part of the same house, or similar. 
-- Sum of area sold is needed to get the total area sold for each transaction.

CREATE TABLE zemljisca_2014 AS
SELECT DISTINCT(ID_POSLA), SUM(POVRSINA_PARCELE)
FROM gurs.main.zemljisca14
GROUP BY ID_POSLA

-- table posli, has entries of all kinds of real estate transactions
-- as I clean the table I will drop columns that are not needed for price prediction
ALTER TABLE gurs.main.posli  DROP COLUMN DATUM_UVELJAVITVE
ALTER TABLE gurs.main.posli  DROP COLUMN DATUM_SKLENITVE_POGODBE
ALTER TABLE gurs.main.posli  DROP COLUMN VKLJUCENOST_DDV
ALTER TABLE gurs.main.posli  DROP COLUMN DATUM_IZTEKA_LIZINGA
ALTER TABLE gurs.main.posli  DROP COLUMN DATUM_PRENEHANJA_LIZINGA
ALTER TABLE gurs.main.posli  DROP COLUMN OPOMBE_O_PRAVNEM_POSLU
ALTER TABLE gurs.main.posli  DROP COLUMN POSREDOVANJE_NEPREMICNINSKE_AGENCIJE
ALTER TABLE gurs.main.posli  DROP COLUMN DATUM_ZADNJE_SPREMEMBE_POSLA
ALTER TABLE gurs.main.posli  DROP COLUMN DATUM_ZADNJE_UVELJAVITVE_POSLA
ALTER TABLE gurs.main.posli DROP COLUMN STOPNJA_DDV
ALTER TABLE gurs.main.posli  DROP COLUMN VRSTA_AKTA
ALTER TABLE gurs.main.posli  DROP COLUMN TRZNOST_POSLA
ALTER TABLE gurs.main.posli  DROP COLUMN POGODBENA_CENA_ODSKODNINA
ALTER TABLE gurs.main.posli  DROP COLUMN VRSTA_KUPOPRODAJNEGA_POSLA
ALTER TABLE gurs.main.posli DROP COLUMN LETO;


-- table deli_stavb has a lot of columns that are not needed for price prediction
-- droping columns as I clean the table
ALTER TABLE gurs.main.deli_stavb DROP COLUMN PRODANI_DELEZ_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN STAVBA_JE_DOKONCANA
ALTER TABLE gurs.main.deli_stavb DROP COLUMN STEVILO_ZUNANJIH_PARKIRNIH_MEST
ALTER TABLE gurs.main.deli_stavb DROP COLUMN POVRSINA_ATRIJA
ALTER TABLE gurs.main.deli_stavb DROP COLUMN STOPNJA_DDV_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN POGODBENA_CENA_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN PROSTORI_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN STEVILO_SOB
ALTER TABLE gurs.main.deli_stavb DROP COLUMN LEGA_DELA_STAVBE_V_STAVBI
ALTER TABLE gurs.main.deli_stavb DROP COLUMN OPOMBE_O_NEPREMICNINI
ALTER TABLE gurs.main.deli_stavb DROP COLUMN POVRSINA_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN UPORABNA_POVRSINA
ALTER TABLE gurs.main.deli_stavb DROP COLUMN E_CENTROID
ALTER TABLE gurs.main.deli_stavb DROP COLUMN N_CENTROID
ALTER TABLE gurs.main.deli_stavb DROP COLUMN ATRIJ
ALTER TABLE gurs.main.deli_stavb DROP COLUMN STEVILKA_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN PARCELNA_STEVILKA_ZA_GEOLOKACIJO
ALTER TABLE gurs.main.deli_stavb DROP COLUMN EVIDENTIRANOST_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN INTERNA_OZNAKA_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN DODATEK_HS
ALTER TABLE gurs.main.deli_stavb DROP COLUMN PRODANA_POVRSINA
ALTER TABLE gurs.main.deli_stavb DROP COLUMN PRODANA_POVRSINA_DELA_STAVBE
ALTER TABLE gurs.main.deli_stavb DROP COLUMN PRODANA_UPORABNA_POVRSINA_DELA_STAVBE


CREATE TABLE gurs.main.stanovanja1 AS
SELECT *
  FROM gurs.main.deli_stavb
 WHERE DEJANSKA_RABA_DELA_STAVBE LIKE '%Stanovanje%'

-- since ID_POSLA is the transaction ID, but is not unique, I will create a table with unique parcels
CREATE TABLE gurs.main.nova_deli_stavb AS
SELECT DISTINCT
     PARCELNA_STEVILKA,
     ID_POSLA,
     SIFRA_KO,
     IME_KO,
     OBCINA,
     VRSTA_ZEMLJISCA,
     POVRSINA_PARCELE
  FROM gurs.main.deli_stavb;
 
-- after we have cleaned the data, we have an interesing problem to solve.
-- Our main table is deli_stavb and posli. Deli_stavb has adresses and other kind of information about
-- the real estate, while posli has information about the transaction.
-- we need to do an inner join between the two tables, to get the price of each real estate.

FROM gurs.main.stanovanja1 AS d
INNER JOIN gurs.main.posli AS a 
ON d.ID_POSLA = a.ID_POSLA;

-- 13/7/2024

--- WE CHANGED DIRECTION:
-- We have flitered the data by obcina, so we only get LJ, 
-- then we choosed building that are for living, 
-- and we filtered them by 'stanovanje' type
SELECT *
  FROM ETN_SLO_2014_KPP_KPP_DELISTAVB_20250615
 WHERE OBCINA = 'LJUBLJANA'
   AND VRSTA_DELA_STAVBE = 1
   AND DEJANSKA_RABA_DELA_STAVBE LIKE '%Stanovanje%';

-- GROUPBY SO WE CAN GET UNIQUE ENTRIES FOR APARTMENTS AND BUILDINGS
SELECT * from clean_stavbe_2014
GROUP by STEVILKA_STAVBE, STEVILKA_DELA_STAVBE;


-- FINAL COLUMNS FOR THE FINAL TABLE
'''
ID_POSLA,
SIFRA_KO,
IME_KO,
OBCINA,
STEVILKA_STAVBE,
STEVILKA_DELA_STAVBE,
NASELJE,
ULICA,
HIŠNA_STEVILKA,
STEVILKA_STANOVANJA_ALI_POSLOVNEGA_PROSTORA,
VRSTA_DELA_STAVBE,
LETO_IZGRADNJE_DELA_STAVBE,
STAVBA_JE_DOKONCANA,
GRADBENA_FAZA,
NOVOGRADNJA,
PRODANI_DELEZ_DELA_STAVBE,
NASDTROPJE_DELA_STAVBE,
DEJANSKA-RABA_DELA_STAVBE,
POVRSINA_DELA_STAVBE,
UPORABNA_POVRSINA,
LETO
'''
--antother cleaning step for data visualization and machine learning step

ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN E_CENTROID;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN N_CENTROID;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN POGODBENA_CENA_DELA_STAVBE;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN PROSTORI_DELA_STAVBE;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN STEVILO_SOB;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN LEGA_DELA_STAVBE_V_STAVBI;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN ATRIJ;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN PARCELNA_STEVILKA_ZA_GEOLOKACIJO;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN EVIDENTIRANOST_DELA_STAVBE;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN INTERNA_OZNAKA_DELA_STAVBE;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN DODATEK_HS;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN PRODANA_POVRSINA;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN PRODANA_POVRSINA_DELA_STAVBE;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN PRODANA_UPORABNA_POVRSINA_DELA_STAVBE;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN POVRSINA_ATRIJA;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN OPOMBE_O_NEPREMICNINI;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN STEVILO_ZUNANJIH_PARKIRNIH_MEST;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN POVRSINA_ATRIJA;
ALTER TABLE gurs.main.clean_stavbe_2014 DROP COLUMN STOPNJA_DDV_DELA_STAVBE;


--- another step where we check the data. In 2014 .csv files, there are some entries that are multiplied,
--- but in table of posli, there is only one entry for each transaction.
select count(ID_POSLA), ID_POSLA from gurs.main.clean_stavbe_2014
GROUP BY ID_POSLA
ORDER BY COUNT(ID_POSLA) DESC;


---deleting the entries that have a NULL in size
DELETE FROM gurs.main.clean_stavbe_2014 
WHERE POVRSINA_DELA_STAVBE IS NULL;

--- cheking how many entries have same ID_POSLA
SELECT COUNT(*) AS rows_to_delete
  FROM gurs.main.clean_stavbe_2014 c 
 WHERE ID_POSLA IN (
   SELECT ID_POSLA
     FROM gurs.main.clean_stavbe_2014 c2 
    GROUP BY ID_POSLA
   HAVING COUNT(*) > 1
   );

-- deleting them
DELETE FROM gurs.main.clean_stavbe_2014 
 WHERE ID_POSLA IN (
   SELECT ID_POSLA
     FROM gurs.main.clean_stavbe_2014 c 
    GROUP BY ID_POSLA
   HAVING COUNT(*) > 1
 );

---merging the clean_stavbe_2014 table with posli table, to get the price of each apartment
create table prodaja2014 AS
from gurs.main.clean_stavbe_2014 as d
INNER JOIN gurs.main.posli AS a
ON d.ID_POSLA = a.ID_POSLA

 --- .csv is ready for machine learning and data visualization

---puting together with zemljisca_2014 table, only keeping matching rows
--- of ID_POSLA from zemljisca_2014 and keeping all of the entries from 
--- clean_stavbe_2014 table


--- cleaning the merged table






