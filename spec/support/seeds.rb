# frozen_string_literal: true

require "rake"
load Rails.root.join "lib/tasks/database.rake"

RSpec.configure do |config|
  config.before :suite do
    Rake::Task.define_task :environment
    Rake::Task["database:seed:production"].invoke
  end
end
