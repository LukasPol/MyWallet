web: bundle exec puma -t 5:5 -e ${RACK_ENV:-production}
js: yarn build --watch
css: yarn build:css --watch
worker: bundle exec sidekiq -C config/sidekiq.yml
