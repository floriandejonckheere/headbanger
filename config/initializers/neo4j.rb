# frozen_string_literal: true

Rails.application.configure do
  config.neo4j.session.type = :bolt
  config.neo4j.session.url = "bolt://neo4j:password@neo4j:7687"

  # Disable TLS
  config.neo4j.session.options = { ssl: false }
end
