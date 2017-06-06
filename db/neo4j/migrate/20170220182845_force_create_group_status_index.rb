# frozen_string_literal: true

class ForceCreateGroupStatusIndex < Neo4j::Migrations::Base
  def up
    add_index :Group, :status, :force => true
  end

  def down
    drop_index :Group, :status
  end
end
