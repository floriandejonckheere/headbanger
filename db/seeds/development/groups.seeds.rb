# frozen_string_literal: true

neo4j_transaction do
  YAML
    .load_file(Rails.root.join("data/development/groups.yml"))
    .deep_symbolize_keys
    .map do |metal_archives_key, data|
    group = Graph::Group.find_or_initialize_by metal_archives_key: metal_archives_key
    group.name = data[:name]
    group.alt_names = data[:alt_names]
    group.description = data[:description]
    group.formed_at = data[:formed_at]
    group.state = data[:state]

    group.country = Graph::Country.find_or_create_by!(code: data[:country])
    data[:artists].each { |key| group.artists << Graph::Artist.find_by(metal_archives_key: key) }
    data[:releases].each { |key| group.releases << Graph::Release.find_by(metal_archives_key: key) }
    data[:themes].each { |theme| group.themes << Graph::Theme.find_or_create_by!(name: theme) }
    data[:genres].each { |genre| group.genres << Graph::Genre.find_or_create_by!(name: genre) }

    group.save!
  end
end
