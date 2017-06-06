# frozen_string_literal: true

module Graph
  ##
  # Generic name node
  #
  class Name
    include Neo4j::ActiveNode

    ##
    # Attributes
    #
    property :name
    property :primary,
             :type => Boolean,
             :default => false

    validates :name,
              :presence => true

    ##
    # Associations
    #
    has_one :in,
            :performer,
            :type => :known_as,
            :model_class => %w[Graph::Artist Graph::Group]

    ##
    # Methods
    #
  end
end
