module Graph
module Concerns
  ##
  # Allow a node to have a root node
  #
  module HasRootNode
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_root_node
        has_one :out,
                  :root_node,
                  :type => :described_by,
                  :model_class => 'Graph::RootNode'
      end
    end
  end
end
end
