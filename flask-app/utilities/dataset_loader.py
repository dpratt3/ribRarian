#!/usr/bin/env python3

# the purpose of this script is to help with dataset loading

import os
import pandas as pd

os.chdir("../../seed-data1/")

# load individual tables 
DatasetPackages = pd.read_csv("DatasetPackages.csv")
Datasets = pd.read_csv("Datasets.csv")
Packages = pd.read_csv("Packages.csv")

# load datasets individually; visually verify

print(DatasetPackages)
print(Datasets)
print(Packages)

# load all data tables 
file_names = os.listdir("data-tables/") # relative
os.chdir("./data-tables/")

data_tables = []
for i in range(0, len(file_names)):
    try:
        data_tables.append(pd.read_csv(file_names[i]))
        print(i)
    except: 
        print('exception')

print(data_tables)



