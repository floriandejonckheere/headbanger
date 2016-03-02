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

      ## Update a data source
      def update(data_source, described_by)
        puts "Updating source #{data_source.type} for attributes #{self.class.virtual_attributes[data_source.type]}"
        ## TODO
      end
    end

    class_methods do |klass|
      # Duplicate priorities for subclasses
      def inherited(subclass)
        super
        subclass.instance_variable_set('@priorities', @priorities.deep_dup)
      end

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

        (@virtual_attributes[opts[:source]] ||= []) << attr

        define_method attr do
          # Virtualizing of associations not yet supported
          raise 'Not implemented yet' if __getobj__.class.association? attr

          data_couple = self.data_sources.each_with_rel.select { |ds, db| ds.type == opts[:source] }

          data_source = data_couple.first.first
          described_by = data_couple.first.last

          valid = (data_source and described_by.timestamp and (described_by.timestamp + opts[:valid_for]).future?)

          puts "timestamp is VALID" if valid
          puts "timestamp is INVALID" unless valid

          update data_source, described_by unless valid

          result = __getobj__.send attr
        end
      end
    end
  end
end
