class ForceCreateLabelUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Label, :uuid, force: true
  end

  def down
    drop_constraint :Label, :uuid
  end
end
