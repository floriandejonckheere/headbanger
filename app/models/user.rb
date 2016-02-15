class User < ActiveRecord::Base
  acts_as_token_authenticatable

  validates :email, :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable

  ## Methods
  def is_admin?
    self.admin || false
  end
end
