FROM floriandejonckheere/docker-ruby-node

MAINTAINER Florian Dejonckheere <florian@floriandejonckheere.be>

# Create user and group
RUN useradd headbanger --create-home --home-dir /app/ --shell /bin/false

WORKDIR /app/
ENV RAILS_ENV production

# Install Gem dependencies
ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN bundle install --deployment --without development test

# Install Node dependencies
ADD package.json /app/
RUN npm install

# Add application
ADD . /app/

# Precompile assets
RUN rails bower:install['--allow-root']
RUN rails bower:resolve['--allow-root']
RUN DB_ADAPTER=nulldb SECRET_KEY_BASE=foo bundle exec rails assets:clobber
RUN DB_ADAPTER=nulldb SECRET_KEY_BASE=foo bundle exec rails assets:precompile

CMD ["/app/docker-entrypoint.sh"]
