# frozen_string_literal: true

class ForceCreateArtistUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Artist, :uuid, :force => true
  end

  def down
    drop_constraint :Artist, :uuid
  end
end
