# frozen_string_literal: true

neo4j_transaction do
  YAML
    .load_file(Rails.root.join("data/development/releases.yml"))
    .deep_symbolize_keys
    .map do |metal_archives_key, data|
    release = Graph::Release.find_or_initialize_by metal_archives_key: metal_archives_key
    release.name = data[:name]
    release.released_at = data[:released_at]

    data[:artists].each { |key| release.artists << Graph::Artist.find_by(metal_archives_key: key) }
    release.group = Graph::Group.find_by(metal_archives_key: data[:group])

    release.save!
  end
end
