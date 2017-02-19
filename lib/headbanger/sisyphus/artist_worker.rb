module Headbanger
module Sisyphus
  ##
  # Implements aggregation methods for Artist
  #
  class ArtistWorker < SisyphusWorker
    model :artist

    def update_sources
      # Check source validity
      if valid?(@instance.musicbrainz_timestamp, 6.months) and
          valid?(@instance.metal_archives_timestamp, 6.months)
        logger.info { "[#{@instance.musicbrainz_key}] Sources validated successfully" }
      else
        logger.info { "[#{@instance.musicbrainz_key}] Sources not valid" }

        # Retrieve source instances
        @musicbrainz = ActiveMusicbrainz::Model::Artist.by_gid @instance.musicbrainz_key
        raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name == 'Person'

        @metal_archives = MetalArchives::Artist.find @instance.metal_archives_key
      end
    end

    def update_instance
      ## Update attributes
      update_attribute :gender
      update_attribute :date_of_birth
      update_attribute :date_of_death
      update_attribute :biography

      ## Update associations
      update_association :country
      update_association :names
      update_association :groups
      update_association :releases
    end

    ##
    ## Attributes
    ##
    def gender
      @musicbrainz.gender.name
    end

    def date_of_birth
      Date.new @musicbrainz.begin_date_year.to_i,
                @musicbrainz.begin_date_month.to_i,
                @musicbrainz.begin_date_day.to_i
    rescue ArgumentError
      # Invalid date (one or more args is nil)
      nil
    end

    def date_of_death
      Date.new @musicbrainz.end_date_year.to_i,
                @musicbrainz.end_date_month.to_i,
                @musicbrainz.end_date_day.to_i
    rescue ArgumentError
      # Invalid date (one or more args is nil)
      nil
    end

    def biography
      # @metal_archives.biography
    end

    ##
    ## Associations
    ##
    def country
      # @instance.country = Graph::Country.find_or_create_by(:country => ISO3166::Country[@metal_archives.country])
    end

    def names
      @instance.names.delete_all

      names = []

      names << @musicbrainz.name
      @musicbrainz.credit_names.each { |acn| names << acn.name }
      @musicbrainz.aliases.each { |a| names << a.name }

      names.uniq.each { |name| @instance.names << Graph::Name.find_or_create_by(:name => name)}
    end

    def groups
        raise Headbanger::NotImplementedError
    end

    def releases
      @musicbrainz.release_groups.each do |release_group|
        next unless release_group.type == 'Album'
      end
      raise Headbanger::NotImplementedError
    end
  end
end
end
