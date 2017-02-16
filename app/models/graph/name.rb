module Graph
  ##
  # Generic name node
  #
  class Name
    include Neo4j::ActiveNode

    # Attributes
    property :name
    property :primary,
                      :type => Boolean

    validates :name,
                  :presence => true

    # Associations
    has_one :in,
              :performer,
              :type => :known_as,
              :model_class => [
                                'Graph::Artist',
                                'Graph::Group'
                              ]
  end
end
