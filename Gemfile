# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 5.1"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Use sidekiq as asynchronous job queue
gem "sidekiq"

# ISO3166 countries
gem "countries"

# User management
gem "devise"
gem "devise_token_auth", github: "lynndylanhurley/devise_token_auth"

# Authorization framework
gem "pundit"

# Data sources
gem "metal_archives", github: "floriandejonckheere/metal_archives"

# Error reporting
gem "sentry-raven"

# GraphQL API
gem "graphql", "~> 1.12"
gem "graphql_devise", "~> 0.14"

# Full-text searching in Postgres
gem "pg_search"

# Job scheduling
gem "clockwork", github: "Rykian/clockwork"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"

  # Debugger
  # gem "debase"

  # Database annotations
  gem "annotate"

  # GraphQL API UI
  gem "graphiql-rails"

  # Authorization framework
  gem "pundit-matchers", github: "aurangzaib-danial/pundit-matchers"

  # RuboCop
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"

  # RSpec
  gem "rspec"
  gem "rspec-rails"

  # Shoulda-matchers
  gem "shoulda-matchers"

  # Time behaviour
  gem "timecop"

  # Factory testing pattern
  gem "factory_bot"
  gem "factory_bot_rails"
  gem "ffaker"
end

group :development do
  gem "listen"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"

  # Debugger
  # gem "ruby-debug-ide"
end
