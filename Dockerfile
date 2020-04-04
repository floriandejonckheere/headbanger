FROM ruby:2.7-alpine

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

ENV RUNTIME_DEPS postgresql nodejs
ENV BUILD_DEPS build-base curl-dev git postgresql-dev

ENV BUNDLER_VERSION 1.15.3

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV APP_HOME /srv
WORKDIR $APP_HOME

ARG APP_ENV=development

# Install system dependencies
RUN apk add --no-cache $BUILD_DEPS $RUNTIME_DEPS

# Install Bundler
RUN gem update --system && \
  gem install bundler --version "$BUNDLER_VERSION" --force

RUN mkdir -p $APP_HOME

# Install Gem dependencies
ADD Gemfile $APP_HOME
ADD Gemfile.lock $APP_HOME

RUN bundle install --deployment --without development test

# Install Node dependencies
ADD package.json /app/
RUN npm install

# Add application
ADD . /app/

# Precompile assets
RUN RAILS_ENV=production rails bower:install['--allow-root']
RUN RAILS_ENV=production rails bower:resolve['--allow-root']
RUN DB_ADAPTER=nulldb SECRET_KEY_BASE=foo bundle exec rails assets:clobber
RUN DB_ADAPTER=nulldb SECRET_KEY_BASE=foo bundle exec rails assets:precompile

CMD ["/app/docker-entrypoint.sh"]
