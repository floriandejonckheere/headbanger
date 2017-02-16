class AddConstraintToGenre < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint 'Graph::Genre', :name
  end

  def down
    drop_constraint 'Graph::Genre', :name
  end
end
