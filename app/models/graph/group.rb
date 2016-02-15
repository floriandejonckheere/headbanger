module Graph
  class Group
    include Neo4j::ActiveNode

    property :gid,            :constraint => :unique
    property :date_formed,    :type => Date

    validates :gid,
                  :presence => true,
                  :format => { :with => /\A[a-z0-0]{8}-[a-z0-0]{4}-[a-z0-0]{4}-[a-z0-0]{4}-[a-z0-0]{12}\Z/ }

    has_many :out,
                  :group_names,
                  :type => :group_known_as,
                  :model_class => 'Graph::GroupName',
                  :dependent => :destroy

    has_many :in,
                  :artists,
                  :type => :member_of,
                  :model_class => 'Graph::Artist'

    has_many :out,
                  :lyrical_themes,
                  :type => :sings_about,
                  :model_class => 'Graph::LyricalTheme'

    has_one :out,
                  :region,
                  :type => :based_in,
                  :model_class => ['Graph::Country', 'Graph::City']
  end
end
