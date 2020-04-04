# frozen_string_literal: true

class ForceCreateReleaseUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Release, :uuid, force: true
  end

  def down
    drop_constraint :Release, :uuid
  end
end
