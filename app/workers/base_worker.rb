class BaseWorker
  include Sidekiq::Worker

  def perform(id)
    object = model.find id # raises Neo4j::RecordNotFound

    data_sources = object.data_sources
    raise "#{model} #{id} has no data sources." unless data_sources.any?

    data_sources.each do |data_source|
      source_model = send data_source.type, data_source.key
      attr_accessor data_source.type
      instance_variable_set "@#{data_source.type.to_s}", source_model
    end

    object.attribute_names.each do |attr|
      result = []
      result << send "update_#{attr}"
      object.update attr => result
    end

    ## names ##
    # TODO: optimize
    #~ artist.names.delete_all
    #~ mb_artist.artist_aliases.each do |aa|
      #~ artist.names << Graph::Name.new(:name => aa.name)
    #~ end

    object.save
  end

  ############################
  ## Override these methods ##
  ############################

  ## Returns the graph model
  def model
  end

  ## Returns a mydatasource instance for key (available later in @mydatasource)
  # def mydatasource(key)
  # end

  ## Updates model's myattribute using the @mydatasources
  # def update_myattribute(model)
  # end
end
