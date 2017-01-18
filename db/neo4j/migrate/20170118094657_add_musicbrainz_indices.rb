class AddIndices < Neo4j::Migrations::Base
  def up
    [:Label, :Genre, :Release, :Group, :Artist].each do |model|
      add_index model, :musicbrainz_key
    end
  end

  def down
    raise Neo4j::IrreversibleMigration
  end
end
