class BaseWorker
  include Sidekiq::Worker

  attr_accessor :object

  def perform(id)
    @object = model.find id # raises Neo4j::RecordNotFound

    ## Attributes
    model.attribute_names.each do |attr|
      # Check validity and retrieve data sources accordingly
      @object[attr] = send attr unless send "#{attr}_valid?"
    end

    ## Associations
    model.associations_keys.reject { |a| a == :data_sources }.each do |assoc|
      # TODO: implement associations
    end

    @object.save!
  end

  def valid_for(hash)
    hash.each do |type, validity|
      data_source = @object.data_sources.find_by!(:type => type)
      valid = data_source.valid_for? validity
      break true if valid

      unless instance_variable_defined? "@#{type.to_s}"
        source_model = send type, data_source.key
        class_eval { attr_accessor data_source.type }
        instance_variable_set "@#{type.to_s}", source_model
        data_source.update_attribute :timestamp, DateTime.now
      end
      break false
    end
  end

  ############################
  ## Override these methods ##
  ############################

  ## Returns the graph model
  # def model
  # end

  ## Returns whether or not the attribute is still valid (using valid_for)
  # def myattribute_valid
  # end

  ## Returns a mydatasource instance for key (available later in @mydatasource)
  # def mydatasource(key)
  # end

  ## Returns [myattribute ...] using @mydatasource
  # def myattribute(model)
  # end
end
