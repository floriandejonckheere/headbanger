module Graph
  class GroupService < AbstractService
    def model
      Graph::Group
    end

    def enumerate
      MetalArchives::Band.all
    end

    def update_instance
      source_instance
      update_attributes

      @instance.save
    end

    protected

    def source_instance
      raise NoDeterminantError unless @instance.metal_archives_key

      # Find MA instance
      @metal_archives = MetalArchives::Band.find! instance.metal_archives_key

      begin
        # Try to find musicbrainz instance
        find_musicbrainz_instance
      rescue NoDeterminantError, IncorrectTypeError => e
        logger.warn "No musicbrainz instance found for #{model} #{@instance.metal_archives_key}: #{e}"
      end
    end

    def update_attributes
      # Year formed
      instance.year_formed = @metal_archives.date_formed
      unless instance.year_formed
        instance.year_formed = Date.new @musicbrainz.begin_date_year.to_i,
                                        @musicbrainz.begin_date_month.to_i,
                                        @musicbrainz.begin_date_day.to_i
      end

      # Description
      instance.description = @metal_archives.comment

      # Status
      instance.status = @metal_archives.status

      ##
      # Update associations
      #

      # Country
      instance.country = @metal_archives.country

      # Names
      instance.names.destroy_all

      primary_name = @musicbrainz.name
      instance.names << Graph::Name.new(:name => primary_name, :primary => true)

      names = []
      @musicbrainz.credit_names.each { |acn| names << acn.name unless acn.name == primary_name }
      @musicbrainz.aliases.each { |a| names << a.name unless acn.name == primary_name }

      names.uniq.each { |name| @instance.names << Graph::Name.new(:name => name) }

      # TODO: Artists
      # TODO: Lyrical themes
      # TODO: Genres
      # TODO: Releases
    end

    def find_musicbrainz_instance
      query = ActiveMusicbrainz::Model.Artist.joins(:area)
                                              .joins(:type)
                                              .where 'artist.name ILIKE :name', :name => @metal_archives.name

      if query.one?
        @musicbrainz = query.first
        raise IncorrectTypeError unless @musicbrainz.type.name === 'Group'

        return
      end

      query = query.where 'area.name ILIKE :name', :name => @metal_archives.country.name

      if query.one?
        @musicbrainz = query.first
        raise IncorrectTypeError unless @musicbrainz.type.name === 'Group'

        return
      end

      query.each do |band|
        next if band.type.name == 'Group'

        band.urls.each do |url|
          if url.url =~ /(http:\/\/)?(www.)?metal-archives.com/
            metal_archives_key = url.url.split('/').last
            break
          end
        end

        if metal_archives_key === @instance.metal_archives_key
          @instance.musicbrainz_key = @musicbrainz.gid

          @musicbrainz = band
          break
        end
      end

      raise NoDeterminantError unless @musicbrainz
    end
  end
end
