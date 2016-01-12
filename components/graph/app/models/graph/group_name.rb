module Graph
  class GroupName
    include Neo4j::ActiveNode

    property :name,       :index => :exact

    validates :name,
                  :presence => true

    has_one :in,
                :group,
                :model_class => :Group,
                :rel_class => :known_as
  end
end
