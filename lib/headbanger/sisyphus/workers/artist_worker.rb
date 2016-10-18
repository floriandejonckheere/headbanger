module Headbanger
module Sisyphus
module Workers
  ##
  # Artist worker
  #
  class ArtistWorker < BaseWorker
    ### Attribute -> data source mapping ###
    attribute [:gender],
                :source => :musicbrainz,
                :valid_for => 1.years

    attribute [:date_of_birth, :date_of_death],
                :source => :musicbrainz,
                :valid_for => 3.months

    attribute [:biography],
                :source => :metal_archives,
                :valid_for => 1.years

    association [:country, :names, :groups, :releases],
                  :source => [:musicbrainz, :metal_archives],
                  :valid_for => 3.months

    model :artist

    ### Attributes ###
    def gender
      @musicbrainz.gender.name
    end

    def date_of_birth
      return Date.new @musicbrainz.begin_date_year.to_i,
                        @musicbrainz.begin_date_month.to_i,
                        @musicbrainz.begin_date_day.to_i
    rescue ArgumentError
      # Invalid date (one or more args is nil)
      return nil
    end

    def date_of_death
      return Date.new @musicbrainz.end_date_year.to_i,
                        @musicbrainz.end_date_month.to_i,
                        @musicbrainz.end_date_day.to_i
    rescue ArgumentError
      # Invalid date (one or more args is nil)
      return nil
    end

    def biography
      @metal_archives.biography
    end

    ### Associations ###
    def country(instance)
      instance.country = Graph::Country.find_or_create_by(:country => ISO3166::Country[@metal_archives.country])
    end

    def names(instance)
      instance.names.delete_all

      add_name = Proc.new { |name| instance.names << Graph::Name.create!(:name => name) }

      @musicbrainz.artist_credit_names.each { |acn| add_name.call acn.name }
      @musicbrainz.aliases.each { |a| add_name.call a.name }
    end

    def groups(instance)
      raise NotImplementedError
    end

    def releases(instance)
      @musicbrainz.release_groups.each do |release_group|
        next unless release_group.type == 'Album'
      end
      raise NotImplementedError
    end
  end
end
end
end
