module Graph
  class DescribedBy
    include Neo4j::ActiveRel
    include Virtualizes

    from_class  ['Graph::Artist', 'Graph::Group']
    to_class    'Graph::DataSource'
    type :described_by

    property :key
    property :priority
    property :cache_timestamp,    :type => Integer

    validates :key,
                  :presence => true
  end
end
