# frozen_string_literal: true

class GenreBuilder < ApplicationBuilder
  def initialize(description:)
    super(name: Genre.name_for(description))
  end

  def associations
    # Guess genre relationships
    Genre.flat_taxonomy.each do |genre|
      model.supergenres << Genre.find_by!(name: genre) if /#{genre}/.match?(model.name)
    end
  end
end
