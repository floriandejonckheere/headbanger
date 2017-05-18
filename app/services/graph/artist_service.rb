module Graph
  class ArtistService < AbstractService
    def model
      Graph::Artist
    end

    def enumerate
      MetalArchives::Artist.all
    end

    def update_instance
      source_instance
      update_attributes
      update_associations

      instance.save
    end

    protected

    def source_instance
      # Find MA instance
      @metal_archives = MetalArchives::Artist.find! instance.metal_archives_key

      # Try to find musicbrainz instance
      find_musicbrainz_instance
    end

    def update_attributes
      # Gender
      instance.gender = @metal_archives.gender&.to_s&.capitalize

      # Date of birth
      instance.date_of_birth = Date.new @musicbrainz.begin_date_year.to_i,
                                         @musicbrainz.begin_date_month.to_i,
                                         @musicbrainz.begin_date_day.to_i

      # Date of death
      instance.date_of_death = Date.new @musicbrainz.end_date_year.to_i,
                                         @musicbrainz.end_date_month.to_i,
                                         @musicbrainz.end_date_day.to_i

      instance.biography = sanitize @metal_archives.biography
    end

    def update_associations
      # Country
      instance.country = @metal_archives.country&.alpha3

      # Names
      instance.names.destroy_all

      primary_name = @musicbrainz.name
      instance.names << Graph::Name.new(:name => primary_name, :primary_name => true)

      names = []
      (@musicbrainz.credit_names + @musicbrainz.aliases + @metal_archives.aliases).each do |acn|
        names << acn.name unless acn.name == primary_name
      end

      names.uniq.each { |name| instance.names << Graph::Name.new(:name => name) }

      # TODO: Releases
    end

    def find_musicbrainz_instance
      query = ActiveMusicbrainz::Model::Artist.joins(:area)
                  .joins(:type)
                  .where 'artist.name ILIKE :name', :name => @metal_archives.name

      if query.one?
        @musicbrainz = query.first
        raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name === 'Person'

        return
      end

      query = query.where 'area.name ILIKE :name', :name => @metal_archives.country.name

      if query.one?
        @musicbrainz = query.first
        raise Headbanger::IncorrectTypeError unless @musicbrainz.type.name === 'Person'

        return
      end

      query.each do |band|
        next if band.type.name == 'Person'

        band.urls.each do |url|
          if url.url =~ /(http:\/\/)?(www.)?metal-archives.com/
            metal_archives_key = url.url.split('/').last
            break
          end
        end

        if metal_archives_key === instance.metal_archives_key
          instance.musicbrainz_key = @musicbrainz.gid

          @musicbrainz = band
          break
        end
      end

      raise Headbanger::NoKeyError unless @musicbrainz
    end
  end
end
