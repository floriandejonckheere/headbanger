# frozen_string_literal: true

namespace :graphql do
  desc "Dump GraphQL schema definition"
  task dump: :environment do
    path = "app/graphql/schema.graphql"

    File.write(Rails.root.join(path), Schema.to_definition)
    puts "Dumped #{path}"
  end
end
