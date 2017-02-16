class AddConstraintToDataNode < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint 'Graph::DataNode', :musicbrainz_key
  end

  def down
    drop_constraint 'Graph::DataNode', :musicbrainz_key
  end
end
