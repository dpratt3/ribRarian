from app.models import db, User, environment, SCHEMA, DatasetPackage

# read in CSV 
import os
import pandas as pd

os.chdir("../seed-data")

# load individual tables 
df = pd.read_csv("DatasetPackages.csv")

# Adds a demo user, you can add other users here if you want
def seed_dataset_packages():
    for index, row in df.iterrows():
        if index == 0:
            continue
        datasets = DatasetPackage(id = index, user_id=row['user_id'], pkg_key=row['pkg_key'], data_key=row['data_key'],table_name = row['table_name'])
        db.session.add(datasets)
    
    db.session.commit()


# Uses a raw SQL query to TRUNCATE or DELETE the users table. SQLAlchemy doesn't
# have a built in function to do this. With postgres in production TRUNCATE
# removes all the data from the table, and RESET IDENTITY resets the auto
# incrementing primary key, CASCADE deletes any dependent entities.  With
# sqlite3 in development you need to instead use DELETE to remove all data and
# it will reset the primary keys for you as well.
def undo_dataset_packages():
    if environment == "production":
        db.session.execute(f"TRUNCATE table {SCHEMA}.dataset_package RESTART IDENTITY CASCADE;")
    else:
        db.session.execute("DELETE FROM dataset_package")
        
    db.session.commit()