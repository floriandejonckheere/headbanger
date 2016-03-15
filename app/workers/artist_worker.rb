class ArtistWorker
  include Sidekiq::Worker

  def perform(artist_id)
    artist = Graph::Artist.find_by!(:gid => artist_id)

    data_sources = artist.data_sources
    raise "Model #{artist_id} has no data sources." unless data_sources.any?

    keys = {}
    data_sources.each { keys[data_source.type] = data_source.key }

    mb_artist = Musicbrainz::Artist.search keys[:musicbrainz]

    # date_of_birth, date_of_death
    artist.date_of_birth = mb_artist.date_begin
    artist.date_of_death = mb_artist.date_end unless model.date_end.future?

    # artist_names
    byebug

    artist.save
  end
end
