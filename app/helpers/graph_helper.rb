module GraphHelper
  ## Development helpers

  def invalidate(uuid)
    Graph::Artist.find(uuid).data_sources.each do |ds|
      ds.update! :timestamp => nil
    end
  end

  def invalidate_all
    Graph::DataSource.all.each do |ds|
      ds.update_attribute! :timestamp, nil
    end
  end

  def create_artist(name)
    mb_artist = Musicbrainz::Artist.find_by! :name => name
    create_artist_by_mbid mb_artist.name
  end

  def create_artist_by_mbid(mbid)
    mb_artist = Musicbrainz::Artist.find_by_mbid mbid
    Neo4j::Transaction.run do
      artist = Graph::Artist.new
      ds = Graph::DataSource.new(:type => :musicbrainz, :key => mb_artist.gid)
      artist.data_sources << ds

      ds.save!
      artist.save!
    end
  end
end
