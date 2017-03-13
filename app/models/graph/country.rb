require 'graph/converters/country_converter'

module Graph
  ##
  # A country
  #
  class Country
    include Neo4j::ActiveNode

    # Attributes
    property :country,
              :type => ISO3166::Country
              # :unique => true

    validates :country,
                      :presence => true

    # Associations
    has_many :in,
                :groups,
                :type => :based_in,
                :model_class => 'Graph::Group',
                :unique => true

    has_many :in,
               :artists,
               :type => :based_in,
               :model_class => 'Graph::Artist',
               :unique => true
  end
end
