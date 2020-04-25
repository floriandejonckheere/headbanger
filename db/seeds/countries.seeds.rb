# frozen_string_literal: true

neo4j_transaction do
  Rails.logger.info "-- Creating countries"

  ISO3166::Country.codes.each do |code|
    Graph::Country.find_or_create_by(code: code)
  end
end
