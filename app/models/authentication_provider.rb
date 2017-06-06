# frozen_string_literal: true

class AuthenticationProvider < ActiveRecord::Base
  has_many :users
  has_many :user_authentications
end
