# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :group_genres,
           dependent: :destroy

  has_many :groups,
           through: :group_genres

  has_many :supergenre_genres,
           dependent: :destroy,
           foreign_key: :subgenre_id,
           inverse_of: :subgenre,
           class_name: "GenreGenre"

  has_many :subgenre_genres,
           dependent: :destroy,
           foreign_key: :supergenre_id,
           inverse_of: :supergenre,
           class_name: "GenreGenre"

  has_many :supergenres,
           through: :supergenre_genres,
           source: :supergenre

  has_many :subgenres,
           through: :subgenre_genres,
           source: :subgenre

  validates :name,
            presence: true,
            uniqueness: true

  def description
    Genre.description_for(name)
  end

  class << self
    def taxonomy
      @taxonomy ||= YAML.load_file(Rails.root.join("data/genres.yml"))
    end

    def flat_taxonomy
      @flat_taxonomy ||= taxonomy.flatten.flatten.compact
    end

    def name_for(description)
      description
        .parameterize(separator: "_")
        .gsub(/_?metal/, "")
    end

    def description_for(name)
      "#{name.titleize} Metal" if name
    end
  end
end