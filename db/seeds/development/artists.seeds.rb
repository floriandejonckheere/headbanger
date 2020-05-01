# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts "-- Creating artists"

  rand(25..50).times { FactoryBot.create(:artist) }
end
