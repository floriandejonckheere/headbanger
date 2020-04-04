# frozen_string_literal: true

class ForceCreateNameUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Name, :uuid, force: true
  end

  def down
    drop_constraint :Name, :uuid
  end
end
