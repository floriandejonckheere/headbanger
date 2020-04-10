# frozen_string_literal: true

class AddConstraintToTheme < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :Theme, :name, force: true
  end

  def down
    drop_constraint :Theme, :name
  end
end
