# frozen_string_literal: true

class ForceCreateDataNodesUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Artist, :uuid, :force => true
    add_constraint :Group, :uuid, :force => true
    add_constraint :Release, :uuid, :force => true

    add_constraint :Artist, :uuid, :force => true
    add_constraint :Group, :uuid, :force => true
    add_constraint :Release, :uuid, :force => true
  end

  def down
    drop_constraint :Artist, :uuid, :force => true
    drop_constraint :Group, :uuid, :force => true
    drop_constraint :Release, :uuid, :force => true

    drop_constraint :Artist, :uuid, :force => true
    drop_constraint :Group, :uuid, :force => true
    drop_constraint :Release, :uuid, :force => true
  end
end
