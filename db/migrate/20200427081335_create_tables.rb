# frozen_string_literal: true

# rubocop:disable Rails/CreateTableWithTimestamps
class CreateTables < ActiveRecord::Migration[6.0]
  def change
    ##
    # Genres
    #
    create_table :genres, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :genres, :name, unique: true

    ##
    # Themes
    #
    create_table :themes, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    add_index :themes, :name, unique: true

    ##
    # Artists
    #
    create_table :artists, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :alt_names, null: false, default: []
      t.string :country, null: false
      t.string :description
      t.string :gender
      t.date :born_at
      t.date :died_at

      t.string :metal_archives_key
      t.string :musicbrainz_key

      t.timestamps
    end

    add_index :artists, :metal_archives_key, unique: true
    add_index :artists, :musicbrainz_key, unique: true

    ##
    # Groups
    #
    create_table :groups, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :alt_names, null: false, default: []
      t.string :status, null: false
      t.string :country, null: false
      t.string :description
      t.date :formed_at

      t.string :metal_archives_key
      t.string :musicbrainz_key

      t.timestamps
    end

    add_index :groups, :metal_archives_key, unique: true
    add_index :groups, :musicbrainz_key, unique: true

    ##
    # Releases
    #
    create_table :releases, id: :uuid do |t|
      t.string :name, null: false
      t.date :released_at

      t.string :metal_archives_key
      t.string :musicbrainz_key

      t.timestamps
    end

    add_index :releases, :metal_archives_key, unique: true
    add_index :releases, :musicbrainz_key, unique: true

    # Genres - Genres
    create_table :genres_genres, id: false do |t|
      t.references :supergenre, null: false, type: :uuid, foreign_key: { to_table: :genres, on_delete: :cascade }
      t.references :subgenre, null: false, type: :uuid, foreign_key: { to_table: :genres, on_delete: :cascade }
    end

    # Artists - Groups
    create_table :artists_groups, id: false do |t|
      t.references :artist, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :group, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
    end

    add_index :artists_groups, [:artist_id, :group_id], unique: true

    # Artists - Releases
    create_table :artists_releases, id: false do |t|
      t.references :artist, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :release, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
    end

    add_index :artists_releases, [:artist_id, :release_id], unique: true

    # Groups - Releases
    create_table :groups_releases, id: false do |t|
      t.references :group, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :release, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
    end

    add_index :groups_releases, [:group_id, :release_id], unique: true

    # Groups - Themes
    create_table :groups_themes, id: false do |t|
      t.references :group, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :theme, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
    end

    add_index :groups_themes, [:group_id, :theme_id], unique: true

    # Groups - Genres
    create_table :groups_genres, id: false do |t|
      t.references :group, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :genre, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
    end

    add_index :groups_genres, [:group_id, :genre_id], unique: true

    ##
    # Users
    #
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :country, null: false

      t.timestamps
    end

    ##
    # Ratings
    #
    create_table :ratings, id: :uuid do |t|
      t.references :user, null: false, type: :uuid, foreign_key: { on_delete: :cascade }
      t.references :rateable, null: false, type: :uuid, polymorphic: true
      t.string :rating, null: false

      t.timestamps
    end

    add_index :ratings, [:user_id, :rateable_id, :rateable_type], unique: true
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
