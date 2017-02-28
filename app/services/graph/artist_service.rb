module Graph
  class ArtistService < GraphService
    include Sidekiq::Worker

    ##
    # Finds or create an instance, and enqueues an update if necessary
    #
    def self.find(musicbrainz_key)
      instance = Graph::Artist.find_or_initialize_by :musicbrainz_key => musicbrainz_key
      ArtistService.perform_async(musicbrainz_key) if instance.stale?

      return instance
    end

    def perform(musicbrainz_key)
      instance = Graph::Artist.find_or_initialize_by :musicbrainz_key => musicbrainz_key
      return if instance.fresh?

      Neo4j::ActiveBase.run_transaction do |tx|
        begin
          ##
          # Update data
          #
          @musicbrainz = Graph::Data::MusicbrainzService.get_artist instance.musicbrainz_key

          # No :metal_archives_key, try to find one
          unless instance.metal_archives_key
            @musicbrainz.l_artist_urls.each do |link|
              if link.url.url =~ /(http:\/\/)?(www.)?metal-archives.com/
                @instance.metal_archives_key = link.url.url.split('/').last
                break
              end
            end
          end

          @metal_archives = Graph::Data::MetalArchivesService.get_artist instance.metal_archives_key

          ##
          # Update attributes
          #

          # Gender
          instance.gender = @musicbrainz.gender.name

          # Date of birth
          instance.date_of_birth = Date.new @musicbrainz.begin_date_year.to_i,
                                            @musicbrainz.begin_date_month.to_i,
                                            @musicbrainz.begin_date_day.to_i

          # Date of death
          instance.date_of_death = Date.new @musicbrainz.end_date_year.to_i,
                                            @musicbrainz.end_date_month.to_i,
                                            @musicbrainz.end_date_day.to_i

          # Biography
          instance.biography = ActionView::Base.full_sanitizer.sanitize @metal_archives.biography

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

          # TODO: Groups
          # TODO: Releases
          # @musicbrainz.release_groups.each do |release_group|
          #   next unless release_group.type == 'Album'
          #   instance.releases << ReleaseService.find_or_create(release_group.gid)
          # end
        rescue => e
          logger.error e
          tx.mark_failed
        end

        instance.save
      end
    end
  end
end
