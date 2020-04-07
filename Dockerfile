FROM ruby:2.7-alpine

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

ENV RUNTIME_DEPS postgresql
ENV BUILD_DEPS build-base curl-dev git postgresql-dev

ENV BUNDLER_VERSION 2.1.4

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV APP_HOME /srv
WORKDIR $APP_HOME

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

# Add application
ADD . $APP_HOME

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
