# frozen_string_literal: true

module Graph
  ##
  # A user's identity
  #
  class Identity
    include Neo4j::ActiveNode
    ##
    # Attributes
    #
    property :provider
    property :uid

    ##
    # Associations
    #
    has_one :out,
            :user,
            :type => :identifies_with,
            :model_class => 'Graph::User'

    ##
    # Methods
    #
    def self.create_from_omniauth(params, user, provider)
      create :user => user,
             :provider => provider,
             :uid => params['uid']
    end
  end
end
