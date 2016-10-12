class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :confirmable,
          :trackable,
          :timeoutable,
          :validatable

  validates :email,
              :presence => true

  def display_name
    self.name || self.email
  end
end
