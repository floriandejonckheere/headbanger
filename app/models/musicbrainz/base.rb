class Musicbrainz::Base < ActiveRecord::Base
  establish_connection :musicbrainz

  self.abstract_class = true
  self.pluralize_table_names = false

  # Disable single table inheritance
  self.inheritance_column = :_type_disabled

  def self.has_artist_credits
    belongs_to :artist_credit, :foreign_key => :artist_credit
    has_many :artist_credit_names, :through => :artist_credit
    has_many :artists, :through => :artist_credit_names
  end

  def self.has_mbid
    define_singleton_method :by_mbid do |mbid|
      find_by :mbid => mbid
    end
  end
end
