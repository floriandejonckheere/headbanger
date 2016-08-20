class BaseWorker
  include Sidekiq::Worker

  attr_accessor :instance

  class << self
    attr_accessor :attributes, :associations, :model
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
  def self.model(model)
    @model = model
  end

  def perform(id)
    # Graph object instance
    @instance = Graph.const_get(self.class.model).find id # raises Neo4j::RecordNotFound

    Neo4j::Transaction.run do
      ## Attributes
      @instance.attribute_names.each do |attr|
        # Check validity and retrieve data sources accordingly
        unless valid? Array(self.class.attributes[attr.to_sym][:source]),
                            self.class.attributes[attr.to_sym][:valid_for]
          @instance[attr] = send attr
        end
      end

      ## Associations
      @instance.associations
                .select { |k,v| v.direction == :out and k != :data_sources }
                .keys.each do |assoc|
        raise "No data source mapping defined for association #{assoc}" unless self.class.associations[assoc.to_sym]
        unless valid? Array(self.class.associations[assoc.to_sym][:source]),
                            self.class.associations[assoc.to_sym][:valid_for]
          send assoc
        end
      end
    end
  end

  private
    def valid?(data_sources, validity)
      root_node = @instance.root_node

      data_sources.each do |type|
        data_source_key = root_node.send "#{type}_key"

        # Continue if a valid timestamp was found
        break true if root_node.timestamp? and
                      (root_node.timestamp + validity).future?

        unless instance_variable_defined? "@#{type.to_s}"
          # Get DataSources::MyDataSource::MyModel.new(key)
          data_source_api = DataSources.const_get type.to_s.camelize
          source_model = data_source_api.const_get self.class.model.camelize
          source_instance = source_model.new data_source_key

          # Set @mydatasource
          class_eval { attr_accessor data_source.type }
          instance_variable_set "@#{type.to_s}", source_model

          # Touch timestamp
          root_node[:"#{type}_timestamp"] = DateTime.now
        end
        break false
      end

      root_node.save!
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
