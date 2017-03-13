class AddConstraintToLyricalTheme < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :LyricalTheme, :name, force: true
  end

  def down
    drop_constraint :LyricalTheme, :name
  end
end
