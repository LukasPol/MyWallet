#!/bin/bash
set -e

rm -f tmp/pids/server.pid

bundle cache || bundle install

yarn install

#mailcatcher

rails db:create
rails db:migrate

#./bin/dev

#rails s

foreman start -f Procfile.dev

#bundle exec puma -t 5:5 -e ${RACK_ENV:-development} -p 3000

#exec "$@"