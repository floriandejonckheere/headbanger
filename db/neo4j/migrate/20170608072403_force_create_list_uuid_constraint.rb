# frozen_string_literal: true

class ForceCreateListUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :List, :uuid, force: true
  end

  def down
    drop_constraint :List, :uuid
  end
end
