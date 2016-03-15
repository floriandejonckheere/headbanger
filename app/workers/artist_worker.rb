class ArtistWorker
  include Sidekiq::Worker

  def perform(artist_id)
    artist = Graph::Artist.find(artist_id) # raises Neo4j::RecordNotFound

    data_sources = artist.data_sources
    raise "Artist #{artist_id} has no data sources." unless data_sources.any?

    keys = {}
    data_sources.each { |ds| keys[ds.type] = ds.key }

    raise "Artist #{artist_id} does not have datasource :musicbrainz" unless keys[:musicbrainz]

    mb_artist = Musicbrainz::Artist.find_by_mbid keys[:musicbrainz] # raises ActiveRecord::RecordNotFound

    ## date_of_birth, date_of_death ##
      artist.date_of_birth = Date.new mb_artist.begin_date_year.to_i,
                                        mb_artist.begin_date_month.to_i,
                                        mb_artist.begin_date_day.to_i
    begin
      artist.date_of_death = Date.new mb_artist.end_date_year.to_i,
                                        mb_artist.end_date_month.to_i,
                                        mb_artist.end_date_day.to_i
    rescue ArgumentError
      # Date is invalid (the artist is still alive)
    end

    ## names ##
    # TODO: optimize
    artist.names.delete_all
    mb_artist.artist_aliases.each do |aa|
      artist.names << Graph::Name.new(:name => aa.name)
    end

    artist.save
  end
end
