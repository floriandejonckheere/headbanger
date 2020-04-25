# frozen_string_literal: true

neo4j_transaction do
  YAML
    .load_file(Rails.root.join("data/development/artists.yml"))
    .deep_symbolize_keys
    .map do |metal_archives_key, data|
    artist = Graph::Artist.find_or_initialize_by metal_archives_key: metal_archives_key
    artist.name = data[:name]
    artist.alt_names = data[:alt_names]
    artist.description = data[:description]
    artist.born_at = data[:born_at]
    artist.gender = data[:gender]

    artist.country = Graph::Country.find_or_create_by!(code: data[:country])
    data[:groups].each { |key| artist.groups << Graph::Group.find_by(metal_archives_key: key) }
    data[:releases].each { |key| artist.releases << Graph::Release.find_by(metal_archives_key: key) }

    artist.save!
  end
end
