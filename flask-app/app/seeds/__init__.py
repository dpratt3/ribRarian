from flask.cli import AppGroup
from .users import seed_users, undo_users
from .datasets import seed_datasets, undo_dataset
from .packages import seed_packages, undo_packages
from .add_data_tables import seed_tables, undo_seed_tables
from app.models.db import db, environment, SCHEMA

# Creates a seed group to hold our commands
# So we can type `flask seed --help`
seed_commands = AppGroup('seed')

# Creates the `flask seed all` command
@seed_commands.command('all')
def seed():
    if environment == 'production':
    # Before seeding, truncate all tables prefixed with schema name
        db.session.execute(f"TRUNCATE table {SCHEMA}.users RESTART IDENTITY CASCADE;")
    # Add a truncate command here for every table that will be seeded.
    
    db.session.commit()
    seed_users()
    db.create_all() #  uncomment this line if table not found erro
    if environment == 'production':
        # Before seeding in production, you want to run the seed undo 
        # command, which will  truncate all tables prefixed with 
        # the schema name (see comment in users.py undo_users function).
        # Make sure to add all your other model's undo functions below
        undo_users()
    seed_users()
    seed_datasets()
    seed_packages()
    seed_tables()
    # Add other seed functions here


# Creates the `flask seed undo` command
@seed_commands.command('undo')
def undo():
    undo_users()
    undo_dataset()
    undo_packages()
    undo_seed_tables()
    # Add other undo functions here