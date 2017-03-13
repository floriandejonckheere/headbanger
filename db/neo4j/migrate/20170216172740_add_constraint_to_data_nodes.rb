class AddConstraintToDataNode < Neo4j::Migrations::Base
  disable_transactions!

  def up
    add_constraint 'Graph::Artist', :musicbrainz_key
    add_constraint 'Graph::Group', :musicbrainz_key
    add_constraint 'Graph::Release', :musicbrainz_key

    add_constraint 'Graph::Artist', :metal_archives_key
    add_constraint 'Graph::Group', :metal_archives_key
    add_constraint 'Graph::Release', :metal_archives_key
  end

  def down
    drop_constraint 'Graph::Artist', :musicbrainz_key
    drop_constraint 'Graph::Group', :musicbrainz_key
    drop_constraint 'Graph::Release', :musicbrainz_key

    drop_constraint 'Graph::Artist', :metal_archives_key
    drop_constraint 'Graph::Group', :metal_archives_key
    drop_constraint 'Graph::Release', :metal_archives_key
  end
end
