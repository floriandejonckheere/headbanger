# frozen_string_literal: true

##
# A user
#
class User
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  include Followable
  include Following

  #
  # Neo4j.rb needs to have property definitions before any validations. So, the property block needs to come before
  # loading your devise modules.
  #
  # If you add another devise module (such as :lockable, :confirmable, or :token_authenticatable), be sure to
  # uncomment the property definitions for those modules. Otherwise, the unused property definitions can be deleted.
  #

  property :created_at,
           :type => DateTime

  property :updated_at,
           :type => DateTime

  ## Database authenticatable
  property :email,
           :type => String,
           :default => ''
           # :constraint => :unique

  validates :email,
            :presence => true

  property :encrypted_password

  ## If you include devise modules, uncomment the properties below.

  ## Recoverable
  property :reset_password_token
  property :reset_password_sent_at,
           :type => DateTime

  ## Rememberable
  # property :remember_created_at, :type => DateTime

  ## Trackable
  property :sign_in_count,
           :type => Integer,
           :default => 0

  validates :sign_in_count,
            :presence => true

  property :current_sign_in_at,
           :type => DateTime

  property :last_sign_in_at,
           :type => DateTime

  property :current_sign_in_ip,
           :type => String

  property :last_sign_in_ip,
           :type => String

  ## Confirmable
  # property :confirmation_token
  # property :confirmed_at, :type => DateTime
  # property :confirmation_sent_at, :type => DateTime
  # property :unconfirmed_email # Only if using reconfirmable

  ## Lockable
  # property :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # validates :failed_attempts, :presence => true
  # property :unlock_token, :type => String # Only if unlock strategy is :email or :both
  # property :locked_at, :type => DateTime

  ## Token authenticatable
  # property :authentication_token, :type => String

  # Include default devise modules. Others available are:
  # :confirmable, :rememberable, :lockable, :timeoutable and :omniauthable
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

  ##
  # Associations
  #
  has_many :out,
           :identities,
           :type => :identifies_with,
           :dependent => :delete, # No callbacks are run
           :unique => { :on => %i[provider uid] }

  has_many :out,
           :lists,
           :type => :has_listed,
           :dependent => :delete, # No callbacks are run
           :unique => { :on => :uuid }

  has_many :out,
           :queued_items,
           :type => :has_queued,
           :model_class => %i[Artist Group Release],
           :unique => { :on => :uuid }

  ##
  # Methods
  #
  def display_name
    name || email
  end

  # Somehow Devise doesn't define this method
  def will_save_change_to_email?
    true
  end
end
