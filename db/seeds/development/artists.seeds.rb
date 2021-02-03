# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts "-- Creating artists"

  100.times { FactoryBot.create(:artist) }
end
