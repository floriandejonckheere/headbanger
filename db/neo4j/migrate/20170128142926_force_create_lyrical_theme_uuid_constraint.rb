class ForceCreateLyricalThemeUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :LyricalTheme, :uuid, force: true
  end

  def down
    drop_constraint :LyricalTheme, :uuid
  end
end
