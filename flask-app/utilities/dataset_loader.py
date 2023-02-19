#!/usr/bin/env python3

# the purpose of this script is to help with dataset loading

import os
import pandas as pd

# os.chdir("../../seed-data/")

# load individual tables 
DatasetPackages = pd.read_csv("../../seed-data/DatasetPackages.csv")
Datasets = pd.read_csv("../../seed-data/Datasets.csv")
Packages = pd.read_csv("../../seed-data/Packages.csv")

# load datasets individually; visually verify

print(DatasetPackages)
print(Datasets)
print(Packages)

# load all data tables 
file_names = os.listdir("../../seed-data/data-tables/") # relative
os.chdir("./data-tables/")

data_tables = []
for i in range(0, len(file_names)):
    try:
        data_tables.append(pd.read_csv(file_names[i]))
        print(i)
    except: 
        print('exception')

print(data_tables)



