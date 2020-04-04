# frozen_string_literal: true

class AddConstraintToDataNodes < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint :Artist, :musicbrainz_key, force: true
    add_constraint :Group, :musicbrainz_key, force: true
    add_constraint :Release, :musicbrainz_key, force: true

    add_constraint :Artist, :metal_archives_key, force: true
    add_constraint :Group, :metal_archives_key, force: true
    add_constraint :Release, :metal_archives_key, force: true
  end

  def down
    drop_constraint :Artist, :musicbrainz_key
    drop_constraint :Group, :musicbrainz_key
    drop_constraint :Release, :musicbrainz_key

    drop_constraint :Artist, :metal_archives_key
    drop_constraint :Group, :metal_archives_key
    drop_constraint :Release, :metal_archives_key
  end
end
