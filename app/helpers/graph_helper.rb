module GraphHelper
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
end
