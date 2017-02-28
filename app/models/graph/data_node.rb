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

    ##
    # Whether the instance is up to date
    #
    def fresh?
      self.updated_at? and (self.updated_at + 6.months).future?
    end

    ##
    # Whether the instance is out of date
    #
    def stale?
      not fresh?
    end
  end
end
