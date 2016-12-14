FROM floriandejonckheere/docker-ruby-node

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

# Create user and group
RUN useradd headbanger --create-home --home-dir /app/ --shell /bin/false

# Install dependencies
ADD Gemfile /app/
ADD Gemfile.lock /app/
ADD package.json /app/

WORKDIR /app/

RUN bundle install --deployment --without development test
RUN npm install

# Add application
ADD . /app/
ENV RAILS_ENV production

# Precompile assets
RUN rails bower:install['--allow-root']
RUN rails bower:resolve['--allow-root']
RUN DB_ADAPTER=nulldb SECRET_KEY_BASE=foo bundle exec rake assets:precompile

# Correct permissions
RUN chown -R headbanger:headbanger/app/
USER headbanger

EXPOSE 8080
CMD ["/app/docker-entrypoint.sh"]
