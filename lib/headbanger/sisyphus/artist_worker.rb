module Headbanger
module Sisyphus
  class ArtistWorker < SisyphusWorker
    model :artist

    def update_sources
      ## Check source validity
      if valid?(@instance.musicbrainz_timestamp, 6.months) and
          valid?(@instance.metal_archives_timestamp, 6.months)
        logger.tagged(@instance.musicbrainz_key) { |l| l.info "Sources validated successfully" }
        return
      end

      logger.tagged(@instance.musicbrainz_key) { |l| l.info "Sources not valid" }

      ## Retrieve source instances
      @musicbrainz = ActiveMusicbrainz::Model::Artist.by_gid @instance.musicbrainz_key
      raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name == 'Person'

      # @metal_archives = MetalArchives::Artist.find @instance.metal_archives_key
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
  end
end
end
