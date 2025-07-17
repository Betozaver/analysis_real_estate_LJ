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

-- now we have to check with addresses had multiple transactions, as is multiple ID_POSLA.











