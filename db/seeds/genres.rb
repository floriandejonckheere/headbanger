# frozen_string_literal: true

Neo4j::ActiveBase.run_transaction do |tx|
  Graph::Genre.taxonomy.each do |genre_key, subgenre_keys|
    genre = Graph::Genre.find_or_create_by!(name: genre_key)

    next unless subgenre_keys

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
