# frozen_string_literal: true

ActiveRecord::Base.transaction do
  Rails.logger.info "-- Creating genres"

  Genre.taxonomy.each do |genre_key, subgenre_keys|
    genre = Genre.find_or_create_by!(name: genre_key)

    subgenres = subgenre_keys&.map { |subgenre_key| Genre.find_or_create_by!(name: subgenre_key) }
    subgenres ||= []

    genre.subgenres.replace(subgenres)
  end
end
