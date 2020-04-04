# frozen_string_literal: true

class ForceCreateNameNameIndex < Neo4j::Migrations::Base
  def up
    add_index :Name, :name, force: true
  end

  def down
    drop_index :Name, :name
  end
end
