#!/bin/bash

# to use, run `chmod + x ./db-helper.sh`
# followed by ./db-helper.sh

rm -r seeddata1/migrations
rm ./instance/dev.db

flask db init
flask db stamp head # fix error: https://stackoverflow.com/questions/17768940/target-database-is-not-up-to-date
flask db migrate
flask db upgrade
flask seed all
