require 'database_cleaner'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :truncation, { :only => %w[users] }
    DatabaseCleaner[:neo4j,
                    :connection => { :type => Rails.application.config.neo4j.session_type,
                                      :path => Rails.application.config.neo4j.session_path }
                  ].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    FactoryGirl.lint
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
