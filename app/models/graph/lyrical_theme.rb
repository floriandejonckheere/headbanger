module Graph
  class LyricalTheme
    include Neo4j::ActiveNode

    property :name,           :constraint => :unique

    validates :name,          :presence => true

    has_many :in,
                :lyrical_themes,
                :type => :sings_about,
                :model_class => 'Graph::Group'
  end
end
