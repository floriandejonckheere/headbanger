module Graph
  class GroupName
    include Neo4j::ActiveNode

    property :name,       :index => :exact

    validates :name,
                  :presence => true

    has_one :in,
                :group,
                :type => :known_as,
                :model_class => 'Graph::Group'
  end
end
