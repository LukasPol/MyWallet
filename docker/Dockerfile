FROM ruby:3.1.2 as base

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update -yqq && apt-get install -y build-essential libpq-dev nodejs

## install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn && rm -rf /var/lib/apt/lists/*


RUN mkdir /app
WORKDIR /app
COPY ../Gemfile /app/Gemfile
COPY ../Gemfile.lock /app/Gemfile.lock

##
RUN gem install bundler:2.3.11
RUN bundle install

COPY ../package.json yarn.lock ./

RUN yarn install

# RUN gem install mailcatcher
RUN gem install foreman

COPY .. /app

COPY docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3000
