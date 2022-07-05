#!/bin/bash
set -e

rm -f tmp/pids/server.pid

bundle cache || bundle install

yarn install

#mailcatcher

rails db:create
rails db:migrate

#rails assets:precompile

./bin/dev

#rails s

# foreman start

#bundle exec puma -t 5:5 -e ${RACK_ENV:-development} -p 3000

#exec "$@"