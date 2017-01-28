class ForceCreateCountryUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Country, :uuid, force: true
  end

  def down
    drop_constraint :Country, :uuid
  end
end
