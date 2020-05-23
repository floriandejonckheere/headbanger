# frozen_string_literal: true

namespace :graphql do
  desc "Dump GraphQL schema definition"
  task dump: :environment do
    path = Rails.root.join("app/graphql/schema.graphql")

    File.write(path, Schema.to_definition)
    puts "Wrote schema definition to #{path}"
  end

  desc "Generate GraphQL fragment types"
  task fragments: :environment do
    path = Rails.root.join("web/src/fragmentTypes.json")

    File.write(path, Schema.to_fragment_types)
    puts "Wrote fragment types to #{path}"
  end
end
