# frozen_string_literal: true

module Graph
  ##
  # A user
  #
  class User
    include Neo4j::ActiveNode
    #
    # Neo4j.rb needs to have property definitions before any validations. So, the property block needs to come before
    # loading your devise modules.
    #
    # If you add another devise module (such as :lockable, :confirmable, or :token_authenticatable), be sure to
    # uncomment the property definitions for those modules. Otherwise, the unused property definitions can be deleted.
    #

    property :created_at, :type => DateTime
    property :updated_at, :type => DateTime

    ## Database authenticatable
    property :email, :type => String, :default => ''
    validates :email, presence: true

    property :encrypted_password

    ## If you include devise modules, uncomment the properties below.

    ## Recoverable
    property :reset_password_token
    property :reset_password_sent_at, :type => DateTime

    ## Rememberable
    # property :remember_created_at, :type => DateTime

    ## Trackable
    property :sign_in_count, :type => Integer, :default => 0
    validates :sign_in_count, presence: true
    property :current_sign_in_at, :type => DateTime
    property :last_sign_in_at, :type => DateTime
    property :current_sign_in_ip, :type =>  String
    property :last_sign_in_ip, :type => String

    ## Confirmable
    # property :confirmation_token
    # property :confirmed_at, :type => DateTime
    # property :confirmation_sent_at, :type => DateTime
    # property :unconfirmed_email # Only if using reconfirmable

    ## Lockable
    # property :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
    # validates :failed_attempts, presence: true
    # property :unlock_token, :type => String # Only if unlock strategy is :email or :both
    # property :locked_at, :type => DateTime

    ## Token authenticatable
    # property :authentication_token, :type => String

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable,
           :registerable,
           :recoverable,
           :trackable,
           :validatable,
           :omniauthable, :omniauth_providers => %i[facebook google_oauth2 twitter]

    ##
    # Attributes
    #
    property :name
    # :unique => true

    ##
    # Associations
    #
    has_many :out,
             :identities,
             :type => :identifies_with,
             :model_class => 'Graph::Identity',
             :unique => { :on => :provider },
             :dependent => :delete

    ##
    # Methods
    #
    def self.create_from_omniauth(auth)
      attributes = {
        :name => auth.info.first_name || auth.info.name || auth.info.email,
        :email => auth.info.email,
        :password => Devise.friendly_token
      }

      create attributes
    end
  end
end