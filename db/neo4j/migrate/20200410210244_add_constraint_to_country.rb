# frozen_string_literal: true

class AddConstraintToCountry < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :Country, :code, force: true
  end

  def down
    drop_constraint :Country, :code
  end
end
