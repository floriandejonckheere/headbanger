FROM ruby:alpine

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev libxml2-dev libxslt-dev postgresql-dev libc-dev linux-headers nodejs tzdata git nodejs
RUN gem install bundler
RUN gem install nokogiri -- --use-system-libraries --with-xml2-config=/usr/local/bin/xml2-config --with-xslt-config=/usr/local/bin/xslt-config

WORKDIR /app
RUN bundle install --without development test

ADD . /app
RUN npm install bower
RUN rails bower:install

RUN chown -R nobody:nogroup /app
USER nobody

ENV RAILS_ENV production

EXPOSE 8080
CMD ["bundle", "exec", "rails", "server", "-p", "8080"]
