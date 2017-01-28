class ForceCreateGenreNameConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Genre, :name, force: true
  end

  def down
    drop_constraint :Genre, :name
  end
end
