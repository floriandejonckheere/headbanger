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
  def self.model(model_sym)
    @model_name = model_sym.to_s
  end

  def perform(root_node_id)
    # Graph object instance
    @model = Graph.const_get(self.class.model_name.camelize)
    @root_node = Graph::RootNode.find root_node_id
    @instance = @root_node.model # raises Neo4j::RecordNotFound

    Neo4j::Transaction.run do
      # Create instance if root_nodes doesn't have it already
      unless @instance
        @instance = @model.new
        @root_node.model = @instance
      end

      ## Attributes
      @model.attribute_names.each do |attr|
        # Check validity and retrieve data sources accordingly
        unless valid? Array(self.class.attributes[attr.to_sym][:source]),
                            self.class.attributes[attr.to_sym][:valid_for]
          @instance[attr] = send attr
        end
      end

      ## Associations
      @model.associations
                .select { |k,v| v.direction == :out and k != :root_node }
                .keys.each do |assoc|
        raise "No data source mapping defined for association #{assoc}" unless self.class.associations[assoc.to_sym]
        unless valid? Array(self.class.associations[assoc.to_sym][:source]),
                            self.class.associations[assoc.to_sym][:valid_for]
          send assoc
        end
      end

      @root_node.save!
      @instance.save!
    end
  end

  private
    def valid?(data_sources, validity)
      data_sources.each do |type|
        data_source_key = @root_node.send :"#{type}_key"

        # Continue if a valid timestamp was found
        break true if @root_node.send :"#{type}_timestamp?" and
                      (@root_node.send(:"#{type}_timestamp") + validity).future?

        unless instance_variable_defined? "@#{type.to_s}"
          # Get DataSources::MyDataSource::MyModel.new(key)
          data_source_api = DataSources.const_get type.to_s.camelize
          source_model = data_source_api.const_get self.class.model_name.camelize
          source_instance = source_model.new data_source_key

          # Set @mydatasource
          class_eval { attr_accessor type }
          instance_variable_set "@#{type.to_s}", source_model.new(data_source_key)

          # Touch timestamp
          @root_node[:"#{type}_timestamp"] = DateTime.now
        end
        break false
      end
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
