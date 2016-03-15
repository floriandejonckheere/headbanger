module Graph
  class Name
    include Neo4j::ActiveNode

    property :name,         :index => :exact

    # Properties specifically for Group
    property :start_date,   :type => Date
    property :end_date,     :type => Date

    validates :name,
                  :presence => true

    has_one :in,
                :performer,
                :type => :known_as,
                :model_class => [
                                  'Graph::Artist',
                                  'Graph::Group'
                                ]
  end
end
