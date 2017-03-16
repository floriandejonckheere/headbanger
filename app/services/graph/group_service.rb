module Graph
  class GroupService < AggregationService
    ##
    # Finds or create an instance, and enqueues an update if necessary
    #
    def self.find(musicbrainz_key)
      instance = Graph::Group.find_or_initialize_by :musicbrainz_key => musicbrainz_key
      GroupService.perform_async(musicbrainz_key) if instance.stale?

      return instance
    end

    def perform(musicbrainz_key)
      raise NoDeterminantError unless musicbrainz_key

      instance = Graph::Group.find_or_initialize_by :musicbrainz_key => musicbrainz_key
      return if instance.fresh?

      Neo4j::ActiveBase.run_transaction do |tx|
        begin
          ##
          # Update data
          #
          @musicbrainz = ActiveMusicbrainz::Model::Artist.by_gid instance.musicbrainz_key
          raise IncorrectTypeError unless @musicbrainz.type.name === 'Group'

          # No :metal_archives_key, try to find one in the musicbrainz database
          unless instance.metal_archives_key
            @musicbrainz.l_artist_urls.each do |link|
              if link.url.url =~ /(http:\/\/)?(www.)?metal-archives.com/
                instance.metal_archives_key = link.url.url.split('/').last
                break
              end
            end
          end

          # TODO: use MetalArchives::Band.find_by!
          raise NoDeterminantError unless instance.metal_archives_key

          @metal_archives = MetalArchives::Band.find! instance.metal_archives_key

          ##
          # Update attributes
          #

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
        rescue => e
          logger.error e
          tx.mark_failed
        end

        instance.save
      end
    end
  end
end
