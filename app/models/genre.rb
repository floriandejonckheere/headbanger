# frozen_string_literal: true

class Genre < ApplicationRecord
  belongs_to :genre,
             optional: true

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
