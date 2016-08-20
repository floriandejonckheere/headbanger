module Graph
module Concerns
  ##
  # Allow a node to have a data source
  #
  module HasDataSource
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_data_source(name, opts = {})
        if opts[:index]
          property "#{name}_key".to_sym,    :index => :exact
        else
          property "#{name}_key".to_sym
        end

        property "#{name}_timestamp",       :type => DateTime
      end
    end
  end
end
end
