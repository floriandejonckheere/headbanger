module Graph
  class DescribedBy
    include Neo4j::ActiveRel

    from_class  ['Graph::Artist', 'Graph::Group']
    to_class    'Graph::DataSource'
    type :described_by

    property :key
    property :priority
    # TODO: change to Integer for performance reasons
    property :timestamp,    :type => DateTime

    validates :key,
                  :presence => true
  end
end
