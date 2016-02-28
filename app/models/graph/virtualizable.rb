module Graph
  module Virtualizable
    extend ActiveSupport::Concern

    included do
      # Priorites class-instance variable
      class << self
        attr_accessor :priorities
      end

      @priorities ||= {}
    end

    class_methods do
      # Duplicate priorities for subclasses
      def inherited(subclass)
        super
        subclass.instance_variable_set('@priorities', @priorities.deep_dup)
      end

      def priority(*args)
        args.each do |hash|
          hash.each do |key, value|
            @priorities[key] = value
          end
        end
      end

      def virtualize(attr, opts)
        alias_method "neo4j_#{attr}".to_sym, attr.to_sym

        raise 'No data source specified' unless opts[:source]
        raise 'No valid period specified' unless opts[:valid_for]
        raise 'No such attribute' unless self.attributes[attr]

        # Virtualizing of associations not yet supported
        raise 'Not implemented yet' if self.association? attr

        define_method attr.to_sym do
          data_source = self.data_sources.find_by(:type => opts[:source]).first

          valid = (data_source and data_source.timestamp and (data_source.timestamp + opts[:valid_for]).future?)

          puts "timestamp is VALID" if valid
          puts "timestamp is INVALID" unless valid

          result = send "neo4j_#{attr}".to_sym
        end
      end
    end
  end
end
