# frozen_string_literal: true

class AddConstraintToCountry < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :Country, :country, :force => true
  end

  def down
    drop_constraint :Country, :country
  end
end
