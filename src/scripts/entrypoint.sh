#!/bin/sh

kill -9 $(cat /app/tmp/pids/server.pid)
rm -rf /app/tmp/pids/server.pid
yarn install --check-files

bundle config set with 'development test'
bundle install

bundle exec rails db:prepare

bundle exec rails s -b 0.0.0.0 -p 3000
