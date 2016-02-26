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

      def virtualize(attr)
        alias_method "neo4j_#{attr}".to_sym, attr.to_sym
        define_method attr.to_sym do

          send "neo4j_#{attr}".to_sym
        end
      end
    end
  end
end
