# frozen_string_literal: true

class AddConstraintToGenre < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :Genre, :name, :force => true
  end

  def down
    drop_constraint :Genre, :name
  end
end
