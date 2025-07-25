2015
We have started with raw data set. 
I have counted the rows in the table, we are starting with 27,100 rows.
We have data for whole Slovenia, but we are interested only in Ljubljana.
Next step is to filter the data by obcina, so we only get Ljubljana.
Then we choose buildings that are for living, so we filter by purpose of building.
We are left with 762 rows. Those rows include apartments, houses, and other types of buildings that are used for living.

---popravljena koda: 3280


We save the new table.
Make a new table, where values are groupby stevilka_stavbe and stevilka_dela_stavbe. No repeated entries.
Deleting apartments and houses, that have NULL in size.
Deleting entries, that are doubled.
353 matches.
--- 3275
Posli - counting, all rows, begining; 31,000 rows
step 2. deleting all entries, that are not sale. So all of the public bidding etc.

---3053 matches

Inner join of tables with buildings and addresses and tables with prices on ID_POSLA
=339 matches.
---2963matches.

Big problem seems investment real estate, which is not properly recorded in GURS .csv files. A lot of missing values, a lot of error values.
report says:
sold 2700 apartments and 350 houses.