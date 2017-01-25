source 'https://rubygems.org'

## User management ##
gem 'devise'
gem 'mail_form'

## Graph store ##
gem 'neo4j'

## Music data ##
gem 'countries'
gem 'metal_archives', '~> 0.6'
gem 'active_musicbrainz', :git => 'https://github.com/floriandejonckheere/active_musicbrainz'

## Sidekiq ##
gem 'redis-namespace'
gem 'sidekiq'
# gem 'sinatra' # For the web frontend

## Web frontend ##
gem 'font-awesome-sass'
gem 'bower-rails'
gem 'nprogress-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

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

group :production do
  gem 'pg'

  # Dummy database for asset precompilation
  gem 'activerecord-nulldb-adapter', :git => 'https://github.com/nulldb/nulldb.git'
end
