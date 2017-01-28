class ForceCreateLyricalThemeNameConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :LyricalTheme, :name, force: true
  end

  def down
    drop_constraint :LyricalTheme, :name
  end
end
