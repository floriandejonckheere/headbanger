class User < ApplicationRecord
  include GrapeTokenAuth::ActiveRecord::TokenAuth

  # https://github.com/mcordell/grape_token_auth/issues/37
  @case_insensitive_keys = [:email]

  validates :email,
              :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :confirmable,
          :trackable,
          :timeoutable,
          :validatable

  def display_name
    self.name || self.email
  end

  # grape_token_auth needs some attributes
  alias_attribute :uid, :email
  alias_attribute :confirmed_at, :created_at

  def confirmed?
    true
  end
end
