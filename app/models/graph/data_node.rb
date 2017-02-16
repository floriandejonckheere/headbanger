module Graph
  ##
  # Node containing data source information
  #
  class DataNode
    include Neo4j::ActiveNode

    # Data sources
    property :musicbrainz_key
    property :metal_archives_key

    property :updated_at,
              :type => DateTime
  end
end
