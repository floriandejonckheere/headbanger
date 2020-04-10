# frozen_string_literal: true

require "neo4j/rspec"

RSpec.configure do |config|
  config.include Neo4j::RSpec::Matchers
end
