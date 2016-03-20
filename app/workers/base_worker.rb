class BaseWorker
  include Sidekiq::Worker

  attr_accessor :object

  class << self
    attr_accessor :attributes, :associations
  end

  def self.attribute(*args)
    Array(args.first).each do |attr|
      (@attributes ||= {})[attr] = args.last
    end
  end

  def self.association(*args)
    Array(args.first).each do |assoc|
      (@associations ||= {})[assoc] = args.last
    end
  end

  def perform(id)
    model = Graph.const_get self.class.name[0..-7]
    @object = model.find id # raises Neo4j::RecordNotFound

    Neo4j::Transaction.run do
      ## Attributes
      model.attribute_names.each do |attr|
        # Check validity and retrieve data sources accordingly
        unless valid? Array(self.class.attributes[attr.to_sym][:source]),
                            self.class.attributes[attr.to_sym][:valid_for]
          @object[attr] = send attr
        end
      end

      ## Associations
      model.associations
                .select { |k,v| v.direction == :out and k != :data_sources }
                .keys.each do |assoc|
        raise "No data source mapping defined for association #{assoc}" unless self.class.associations[assoc.to_sym]
        unless valid? Array(self.class.associations[assoc.to_sym][:source]),
                            self.class.associations[assoc.to_sym][:valid_for]
          send assoc
        end
      end

      @object.data_sources.each { |ds| ds.save! }
      @object.save!
    end
  end

  ## Private methods ##
  def valid?(arr, validity)
    arr.each do |type|
      data_source = @object.data_sources.find_by!(:type => type)
      break true if data_source.timestamp? and
                    (data_source.timestamp + validity).future?

      unless instance_variable_defined? "@#{type.to_s}"
        source_model = send type, data_source.key
        class_eval { attr_accessor data_source.type }
        instance_variable_set "@#{type.to_s}", source_model

        # Set timestamp on data sources, but don't persist yet
        data_source.timestamp = DateTime.now
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


  ## Override these methods in your subclass

  ### Attributes ###

  ## Returns a mydatasource instance for key (available later in @mydatasource)
  # def mydatasource(key)
  # end

  ## Returns [myattribute ...] using @mydatasource
  # def myattribute
  # end

  ### Associations ###

  ## Does not return anything but manipulates @object using @mydatasource
  # def myassociation
  # end
end
