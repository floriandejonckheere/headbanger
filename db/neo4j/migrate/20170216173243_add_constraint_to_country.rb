class AddConstraintToCountry < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint 'Graph::Country', :country
  end

  def down
    drop_constraint 'Graph::Country', :country
  end
end
