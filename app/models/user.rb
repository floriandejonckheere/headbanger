class User < ActiveRecord::Base
  include GrapeTokenAuth::ActiveRecord::TokenAuth

  validates :email, :presence => true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable

  ## Methods
  def is_admin?
    self.admin || false
  end
end
