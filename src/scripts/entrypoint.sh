#!/bin/sh
./scripts/wait-for-it.sh -t 0 $POSTGRES_HOST:$POSTGRES_PORT

kill -9 $(cat /app/tmp/pids/server.pid)
rm -rf /app/tmp/pids/server.pid
yarn install --check-files

bundle config set with 'development test'
bundle install

bundle exec rails db:exists || bundle exec rails db:setup

bundle exec rails s -b 0.0.0.0 -p 3000
