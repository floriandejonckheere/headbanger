# frozen_string_literal: true

Neo4j::ActiveBase.run_transaction do |tx|
  TAXONOMY = {
    alternative: [:electronic, :industrial, :funk, :nu, :rap],
    black: [],
    death: [:death_doom, :death_trash, :deathcore, :grindcore, :melodic, :symphonic_death],
    doom: [:death_doom, :drone, :gothic, :stoner, :sludge],
    folk: [:christian, :celtic, :pagan, :pirate, :viking],
    heavy: [:epic, :glam, :groove, :gothic, :neoclassical, :power, :speed, :stoner, :symphonic],
    metalcore: [:deathcore],
    thrash: [:death_trash, :funk, :groove, :blackened_thrash],
    progressive: [:avantgarde, :djent],
  }.freeze

  TAXONOMY.each do |genre_key, subgenre_keys|
    genre = Graph::Genre.find_or_create_by!(name: genre_key)

    subgenres = subgenre_keys.map do |subgenre_key|
      Graph::Genre.find_or_create_by!(name: subgenre_key)
    end

    subgenres.each { |s| s.supergenres.replace_with [] }

    genre.subgenres.replace_with(subgenres)
  end
rescue StandardError => e
  tx.mark_failed
  raise e
end
