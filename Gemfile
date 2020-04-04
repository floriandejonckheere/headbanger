# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

## User management ##
gem "devise"
gem "devise-neo4j"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-twitter"

## Graph store ##
gem "neo4j"

## Music data ##
gem "active_musicbrainz", github: "floriandejonckheere/active_musicbrainz"
gem "countries"
gem "metal_archives"

## Sidekiq ##
gem "redis-namespace"
gem "sidekiq"
# gem 'sinatra' # For the web frontend

## JSON API ##
gem "jsonapi-resources"
gem "jsonapi-utils"
gem "rack-cors"

## Search engine ##
gem "searchkick"

# Logging
gem "lograge"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Puma as the app server
gem "puma"

group :development do
  # Start API server and web app
  gem "foreman"

  gem "listen"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  # Use sqlite3 as the database for Active Record
  # gem 'sqlite3'

  # Debugger
  # gem 'debase', '~> 0.2.1'

  # RuboCop
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  # BDD testing for Ruby
  gem "rspec"
  gem "rspec-rails"

  # Factory pattern for testing
  gem "factory_girl"
  gem "factory_girl_rails"

  # Fake data generator
  gem "faker"
end

group :production do
  gem "pg"

  # Dummy database for asset precompilation
  gem "activerecord-nulldb-adapter", git: "https://github.com/nulldb/nulldb.git"

  # Notify exceptions
  gem "exception_notification"
end
