class Group
  include Neo4j::ActiveNode

  property :gid,          :index => :exact,       :constraint => :unique
  property :date_formed,  :type => Date

  validates :gid,
                :presence => true,
                :format => { :with => /\A[a-z0-0]{8}-[a-z0-0]{4}-[a-z0-0]{4}-[a-z0-0]{4}-[a-z0-0]{12}\Z/ }

  has_many :out,
                :group_names,
                :model_class => :GroupName,
                :rel_class => :known_as,
                :dependent => :destroy
end
