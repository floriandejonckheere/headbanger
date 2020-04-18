# frozen_string_literal: true

RSpec.configure do |config|
  config.include Neo4j::RSpec::Matchers

  config.before :all do
    Neo4j::ActiveBase
      .current_session
      .query("MATCH (n) WHERE NOT n:`Neo4j::Migrations::SchemaMigration` AND NOT n:`Genre` DETACH DELETE n")
  end

  config.around do |example|
    Neo4j::ActiveBase.run_transaction do |tx|
      example.run
      tx.mark_failed
    end
  end
end
