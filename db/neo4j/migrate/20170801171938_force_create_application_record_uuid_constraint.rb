class ForceCreateApplicationRecordUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :ApplicationRecord, :uuid, force: true
  end

  def down
    drop_constraint :ApplicationRecord, :uuid
  end
end
