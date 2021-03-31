# frozen_string_literal: true

require "graph"

namespace :graph do
  desc "Render graph visualization of genres"
  task genres: :environment do
    digraph do
      compact!

      Genre.includes(:supergenres, :subgenres).all.each do |genre|
        genre.supergenres.each { |supergenre| edge(supergenre.name, genre.name) }
        genre.subgenres.each { |subgenre| edge(genre.name, subgenre.name) }
      end

      save "genres", "png"
    end
  end
end
