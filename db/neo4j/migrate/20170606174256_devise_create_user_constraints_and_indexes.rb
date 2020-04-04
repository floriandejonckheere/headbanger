# frozen_string_literal: true

class DeviseCreateUserConstraintsAndIndexes < Neo4j::Migrations::Base
  def up
    add_constraint :User, :email, force: true
    # add_constraint :User, :remember_token, :force => true
    add_constraint :User, :reset_password_token, force: true
    # add_constraint :User, :confirmation_token, :force => true
    # add_constraint :User, :unlock_token, :force => true
    # add_constraint :User, :authentication_token, :force => true
  end

  def down
    drop_constraint :User, :email
    # drop_constraint :User, :remember_token
    drop_constraint :User, :reset_password_token
    # drop_constraint :User, :confirmation_token
    # drop_constraint :User, :unlock_token
    # drop_constraint :User, :authentication_token
  end
end
