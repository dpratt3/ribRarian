#!/bin/bash

# to use, run `chmod + x ./db-helper.sh`
# followed by ./db-helper.sh

rm -r migrations
rm app/dev.db

flask db init
flask db migrate
flask db upgrade
