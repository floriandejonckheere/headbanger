class ForceCreateDataNodeUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :DataNode, :uuid, force: true
  end

  def down
    drop_constraint :DataNode, :uuid
  end
end
