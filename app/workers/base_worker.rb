class BaseWorker
  include Sidekiq::Worker

  attr_accessor :instance

  class << self
    attr_accessor :attributes, :associations, :model_name
  end

  ##
  # Declare attribute
  #
  def self.attribute(*args)
    Array(args.first).each do |attr|
      (@attributes ||= {})[attr] = args.last
    end
  end

  ##
  # Declare association
  #
  def self.association(*args)
    Array(args.first).each do |assoc|
      (@associations ||= {})[assoc] = args.last
    end
  end

  ##
  # Declare model
  #
  def self.model(model_sym)
    @model_name = model_sym.to_s
  end

  ##
  # Retrieve data fields on a node
  #
  def perform(musicbrainz_key)
    @model = Graph.const_get(self.class.model_name.camelize)
    # Instance of Graph::Model
    begin
      @instance = @model.find_by! :musicbrainz_key => musicbrainz_key
    rescue Neo4j::RecordNotFound
      logger.info "Creating #{self.class.model_name} with mbid #{musicbrainz_key}"
      @instance = @model.new :musicbrainz_key => musicbrainz_key
    end

    Neo4j::Transaction.run do
      ## Attributes
      self.class.attributes.each do |attr, opts|
        validate_data_sources Array(opts[:source]), opts[:valid_for]

        logger.debug "[#{self.class.model_name}][#{musicbrainz_key}] update_attr #{attr}"
        @instance[attr] = send attr
      end

      ## Associations
      self.class.associations.each do |assoc, opts|
        validate_data_sources Array(opts[:source]), opts[:valid_for]

        logger.debug "[#{self.class.model_name}][#{musicbrainz_key}] update_assoc #{assoc}"
        send assoc, @instance
      end

      @instance.save!
    end
  end

  private
    def validate_data_sources(data_sources, validity)
      data_sources.each do |source_type|
        key = @instance.send :"#{source_type}_key"

        # Break on valid source
        break true if @instance.send :"#{source_type}_timestamp?" and
                      (@instance.send(:"#{source_type}_timestamp") + validity).future?

        # Headbanger::DataSources::MyDataSource
        data_source_api = Headbanger::DataSources.const_get source_type.to_s.camelize
        # Headbanger::DataSources::MyDataSource::MyModel
        source_model = data_source_api.const_get self.class.model_name.camelize
        # Headbanger::DataSources::MyDataSource::MyModel.new key
        source_instance = source_model.new key

        # Set @mydatasource
        class_eval { attr_accessor source_type }
        instance_variable_set "@#{source_type.to_s}", source_instance

        @instance[:"#{source_type}_timestamp"] = DateTime.now
      end
    end

    def logger
      Headbanger::Sisyphus.logger
    end

  ############################
  ## Override these methods ##
  ############################

  ## Refer to example_worker.rb for a somewhat complete example

  ### Data source mapping ###

  ## Call these methods at the beginning of your class definition

  ## Define an attribute's data sources and lifetime
  # attribute [:myattribute, :myotherattribute],
  #             :source => :mydatasource,
  #             :valid_for => 3.months

  ## Define an association's data sources and lifetime
  # association :myassociation,
  #               :source => [:mydatasource, myotherdatasource],
  #               :valid_for => 3.months

  ## Define the model class, used for Graph::MyModel
  # model :mymodel

  ## Override these methods in your subclass

  ### Attributes ###

  ## Returns [myattribute ...] using @mydatasource
  # def myattribute
  # end

  ### Associations ###

  ## Does not return anything but manipulates @object using @mydatasource
  # def myassociation
  # end
end
