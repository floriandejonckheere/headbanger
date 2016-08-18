source 'https://rubygems.org'

## API ##
gem 'grape'
gem 'grape_token_auth'

## User management ##
gem 'devise'

# Angular
gem 'angular_rails_csrf', :git => 'https://github.com/tpmullan/angular_rails_csrf.git'
gem 'angular-rails-templates', :git => 'https://github.com/pitr/angular-rails-templates.git'

## Graph store ##
gem 'neo4j'
gem 'data_migrator', :github => 'ifeelgoods/data-migrator'

## Music data ##
gem 'countries'
gem 'metal_archives', :github => 'floriandejonckheere/metal_archives'

## Sidekiq ##
gem 'redis-namespace'
gem 'sidekiq'
# gem 'sinatra' # For the web frontend

## Web frontend ##
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'font-awesome-sass'
gem 'bower-rails'
gem 'listen' # for config/initializers/angular_templates.rb

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Puma as the app server
gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-sidekiq'
end

group :development do
  # Capistrano deployment
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-upload-config'
  gem 'capistrano3-puma'
end

group :production, :staging do
  # Use PostgreSQL as the database for Active Record
  gem 'pg'
end
