# frozen_string_literal: true

class ForceCreateGenreUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Genre, :uuid, :force => true
  end

  def down
    drop_constraint :Genre, :uuid
  end
end
