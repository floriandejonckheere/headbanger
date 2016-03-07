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
      private
      def update(data_source)
        klass = DataSources.const_get data_source.type.to_s.camelize
        attrs = klass.update_attributes self.class.to_s.split('::').last,
                                          data_source,
                                          self.class.virtual_attributes[data_source.type]

        self.class.virtual_attributes[data_source.type].each do |attr|
          __getobj__.send :update, attr.to_sym => attrs[attr]
        end
        data_source.update :timestamp => DateTime.now
      end
    end

    class_methods do
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
      ##  :source can be an array
      ##  :valid_for can be ActiveSupport::Time or :forever
      ##
      def virtualize(attr, opts)
        raise 'No data source specified' unless opts[:source]
        raise 'No timeout specified' unless opts[:valid_for]

        source = Array(opts[:source])
        source.each { |s|  (@virtual_attributes[s] ||= []) << attr }

        define_method attr do
          # Virtualizing of associations not yet supported
          raise 'Not implemented yet' if __getobj__.class.association? attr

          selected_sources = self.data_sources.select { |data_source| source.include? data_source.type }

          raise 'Not enough data sources to satisfy attribute source' if selected_sources.count < source.count

          begin
            selected_sources.each do |data_source|
              unless data_source.timestamp
                # There's at least one selected_source which hasn't been harvested yet
                raise Exception
              end
              next if opts[:valid_for] == :forever
              raise Exception unless (data_source.timestamp + opts[:valid_for]).future?
            end
          rescue Error
            update data_source
          end

          result = __getobj__.send attr
        end
      end
    end
  end
end
