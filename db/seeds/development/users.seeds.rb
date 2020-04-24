# frozen_string_literal: true

neo4j_transaction do
  100.times { FactoryBot.create :user }
end
