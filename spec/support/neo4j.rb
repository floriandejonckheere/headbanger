# frozen_string_literal: true

RSpec.configure do |config|
  config.include Neo4j::RSpec::Matchers

  config.before do
    Neo4j::ActiveBase
      .current_session
      .query("MATCH (n) WHERE NOT n:`Neo4j::Migrations::SchemaMigration` AND NOT n:`Genre` DETACH DELETE n")
  end
end
