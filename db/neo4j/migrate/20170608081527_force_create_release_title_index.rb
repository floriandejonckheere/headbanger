# frozen_string_literal: true

class ForceCreateReleaseTitleIndex < Neo4j::Migrations::Base
  def up
    add_index :Release, :title, :force => true
  end

  def down
    drop_index :Release, :title
  end
end
