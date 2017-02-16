class AddConstraintToLyricalTheme < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint 'Graph::LyricalTheme', :name
  end

  def down
    drop_constraint 'Graph::LyricalTheme', :name
  end
end
