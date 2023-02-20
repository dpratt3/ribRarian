#!/bin/bash

# to use, run `chmod + x ./db-helper.sh`
# followed by ./db-helper.sh

rm -r ../seed-data1/migrations
rm ./instance/dev.db

flask db init
flask db migrate
flask db stamp head
flask db upgrade
flask seed all
