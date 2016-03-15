source 'https://rubygems.org'

## API ##
gem 'grape'

## User management ##
gem 'devise', '~> 3.5.4'
gem 'simple_token_authentication', '~> 1.0'
gem 'angular_rails_csrf'

## Graph store ##
gem 'neo4j', '~> 6.1.1'
gem 'data_migrator', :github => 'ifeelgoods/data-migrator'
gem 'countries'
gem 'musicbrainz'
gem 'redis-namespace'
gem 'sidekiq'

## Web frontend ##
gem 'bootstrap', '~> 4.0.0.alpha3'
gem 'font-awesome-sass', '~> 4.4.0'
gem 'bower-rails', '~> 0.10.0'
gem 'listen', '~> 3.0' # for config/initializers/angular_templates.rb

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Puma as the app server
gem 'puma'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Ignore asset logging
  gem 'quiet_assets'
end

group :test do
  gem 'rspec', '~> 3.4.0'
  gem 'rspec-rails', '~> 3.0'
  gem 'database_cleaner', '~> 1.5.1'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'rspec-sidekiq'
end

group :development do
  # PostGres
  gem 'pg'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'

  # Capistrano deployment
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm'
  gem 'capistrano-upload-config'
  gem 'capistrano3-puma'
end
