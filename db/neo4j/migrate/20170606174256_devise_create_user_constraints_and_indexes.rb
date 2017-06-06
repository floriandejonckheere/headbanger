# frozen_string_literal: true

class DeviseCreateUserConstraintsAndIndexes < Neo4j::Migrations::Base
  def change
    add_index :Graph::User, :email, :force => true
    add_index :Graph::User, :remember_token, :force => true
    add_index :Graph::User, :reset_password_token, :force => true
    # add_index :User, :confirmation_token, :force => true
    # add_index :User, :unlock_token, :force => true
    # add_index :User, :authentication_token, :force => true
  end
end
