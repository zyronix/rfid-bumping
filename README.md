# Portable RFID bumping device
This repository contains all the scripts and datasets used in "Portable RFID Bumping device" written by Romke van Dijk & Loek Sangers

https://homepages.staff.os3.nl/~delaat/rp/2015-2016/p04/report.pdf

## calculate_complex.py
This script calculates the leftover complexity and uses the craptev1 solver. We disabled the bruteforcing part and used it just to calculate the leftover complexity. The script output a CSV to the STDOUT. Change the variable CRAPTEV and DATASETS to match your environment.

## calculate_missing_nested.py
This script calculates how many key were not found using the nested authentication attach. Extract an archive in the folder datasets and run this script. It will output the success rate.

## create_csv.sh
This script converts a dataset to a csv file so it can be analysed. You should not have to run this script, because the folder dataset already contains all the csv files.

## dbtoeml.py
This script exports one specific tag from the database. The first argument is the UID (lowcase) the second argument is the db file. 

Example:

```
./dbtoempy.py 12345678 cards.db
```

## gather_data.sh
This script was used to gather all the data during the research. It was run on the Nexus phone. Change the variable PROXMARK to match your environment. To let the script change n keys, change the variable TOTALKEYS to n - 1. Change BLOCK to the block containing the access permissions of the first sector. The script will always when it exits write the default key FFFFFFFFFFFF back to all the used sectors.
