from app.models import db, User, environment, SCHEMA, Dataset

# read in CSV 
import os
import pandas as pd

# os.chdir("../seed-data")

# load individual tables 
df = pd.read_csv("../seed-data/Datasets.csv")

# Adds a demo user, you can add other users here if you want
def seed_datasets():
    for index, row in df.iterrows():
        if index == 0:
            continue
        datasets = Dataset(id = index, name=row['name'], date_modified = row['date_modified'])
        db.session.add(datasets)
    
    db.session.commit()


# Uses a raw SQL query to TRUNCATE or DELETE the users table. SQLAlchemy doesn't
# have a built in function to do this. With postgres in production TRUNCATE
# removes all the data from the table, and RESET IDENTITY resets the auto
# incrementing primary key, CASCADE deletes any dependent entities.  With
# sqlite3 in development you need to instead use DELETE to remove all data and
# it will reset the primary keys for you as well.
def undo_dataset():
    if environment == "production":
        db.session.execute(f"TRUNCATE table {SCHEMA}.dataset RESTART IDENTITY CASCADE;")
    else:
        db.session.execute("DELETE FROM dataset")
        
    db.session.commit()