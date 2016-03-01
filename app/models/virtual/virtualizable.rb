module Virtual
  module Virtualizable
    extend ActiveSupport::Concern

    included do
      # Priorites class-instance variable
      class << self
        attr_accessor :priorities, :virtual_attributes
      end

      @priorities ||= {}
      @virtual_attributes ||= {}
    end

    class_methods do |klass|
      # Duplicate priorities for subclasses
      def inherited(subclass)
        super
        subclass.instance_variable_set('@priorities', @priorities.deep_dup)
      end

      # Delegate methods to Graph::*
      #~ def method_missing(symbol, *args)
        #~ byebug
        #~ puts self.to_sym
        #~ Graph.constantize(self.to_sym).send symbol, *args
      #~ end

      ## Define data source priorities
      ##
      ## priority :data_source => PRIORITY
      ##            [, :data_source_2 => PRIORITY]
      ##
      ## PRIORITY can be :very_low, :low, :normal, :high, :very_high
      ##
      def priority(*args)
        args.each do |hash|
          hash.each do |key, value|
            @priorities[key] = value
          end
        end
      end

      ## Virtualize a property
      ##
      ## virtualize :attribute,
      ##              :source => :data_source,
      ##              :valid_for => 1.month
      ##
      ##
      def virtualize(attr, opts)
        raise 'No data source specified' unless opts[:source]
        raise 'No valid period specified' unless opts[:valid_for]
        #~ raise 'No such attribute' unless self.attributes[attr]

        (@virtual_attributes[opts[:source]] ||= []) << attr

        # Virtualizing of associations not yet supported
        #~ raise 'Not implemented yet' if self.association? attr

        define_method attr.to_sym do
          data_source = self.data_sources.find_by(:type => opts[:source])

          valid = (data_source and data_source.timestamp and (data_source.timestamp + opts[:valid_for]).future?)

          puts "timestamp is VALID" if valid
          puts "timestamp is INVALID" unless valid

          update data_source unless valid

          result = __getobj__.send attr
        end
      end

      ## Update a data source
      private
      def update(data_source)
        puts "Updating source #{data_source.type} for attributes #{@virtual_attributes[data_source.type]}"
      end
    end
  end
end
