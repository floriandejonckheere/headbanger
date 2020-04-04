# frozen_string_literal: true

class ForceCreateIdentityUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Identity, :uuid, force: true
  end

  def down
    drop_constraint :Identity, :uuid
  end
end
