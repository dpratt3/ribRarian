from app.models import db, User, environment, SCHEMA, Dataset
from sqlalchemy import create_engine
import sqlite3 

# read in CSV 
import os
import pandas as pd

# os.chdir("../seed-data/data-tables")
file_names = os.listdir("../seed-data/data-tables/") # relative
engine = create_engine("sqlite://")

# load individual tables

def seed_tables():
        for i in range(0, len(file_names)):
            try: 
                df = pd.read_csv("../seed-data/data-tables/" + file_names[i])
                table_name = file_names[i].split('.csv')[0]
                df.to_sql(name=table_name, con=engine, index=False, if_exists='replace')
                print(table_name)
            except:
                print('exception')
                
        db.session.commit()
    
        

# Uses a raw SQL query to TRUNCATE or DELETE the users table. SQLAlchemy doesn't
# have a built in function to do this. With postgres in production TRUNCATE
# removes all the data from the table, and RESET IDENTITY resets the auto
# incrementing primary key, CASCADE deletes any dependent entities.  With
# sqlite3 in development you need to instead use DELETE to remove all data and
# it will reset the primary keys for you as well. 
def undo_seed_tables():
    if environment == "production":
        db.session.execute(f"TRUNCATE table {SCHEMA}.add_data.tables RESTART IDENTITY CASCADE;")
    else:
        db.session.execute("DELETE FROM add_data.tables")
        
    db.session.commit()