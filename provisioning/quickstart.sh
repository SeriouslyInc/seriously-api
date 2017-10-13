#!/bin/bash

set -e # exit immediately if something fails
set -x # echo commands as they run, to show where things went wrong

# Go to the mapped directory (where the host rails app lives)
cd /vagrant

# copy in figaro dev config file if needed
# if [ ! -f /vagrant/config/application.yml ]; then
#     cp /vagrant/config/application-template.yml /vagrant/config/application.yml
# fi

# Install the application's gem dependencies
bundle install

# setup the db if needed, otherwise just migrate it
# if echo "\c $PGDATABASE; \dt" | psql 2>/dev/null | grep schema_migrations
# then
#    # bundle exec rake db:migrate
# else
#    # bundle exec rake db:setup db:seed
# fi

# Run the application and dependencies
foreman start -f Procfile.development