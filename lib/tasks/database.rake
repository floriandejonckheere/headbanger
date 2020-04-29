# frozen_string_literal: true

namespace :database do
  desc "Seed production and development database"
  task seed: %w(seed:production seed:development)

  namespace :seed do
    desc "Seed production database"
    task production: :environment do
      Dir[Rails.root.join("db/seeds/*.rb")].sort.each { |f| require f }
    end

    desc "Seed development database"
    task development: :environment do
      Dir[Rails.root.join("db/seeds/development/*.rb")].sort.each { |f| require f }
    end
  end
end
