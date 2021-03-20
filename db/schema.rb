# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_20_174020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "artists", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "alt_names", default: [], null: false
    t.string "country", null: false
    t.string "description"
    t.string "gender"
    t.date "born_on"
    t.date "died_on"
    t.string "metal_archives_key"
    t.string "musicbrainz_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "synced_at"
    t.index ["metal_archives_key"], name: "index_artists_on_metal_archives_key", unique: true
    t.index ["musicbrainz_key"], name: "index_artists_on_musicbrainz_key", unique: true
  end

  create_table "artists_groups", id: false, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.uuid "group_id", null: false
    t.index ["artist_id", "group_id"], name: "index_artists_groups_on_artist_id_and_group_id", unique: true
    t.index ["artist_id"], name: "index_artists_groups_on_artist_id"
    t.index ["group_id"], name: "index_artists_groups_on_group_id"
  end

  create_table "artists_releases", id: false, force: :cascade do |t|
    t.uuid "artist_id", null: false
    t.uuid "release_id", null: false
    t.index ["artist_id", "release_id"], name: "index_artists_releases_on_artist_id_and_release_id", unique: true
    t.index ["artist_id"], name: "index_artists_releases_on_artist_id"
    t.index ["release_id"], name: "index_artists_releases_on_release_id"
  end

  create_table "genres", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "genres_genres", id: false, force: :cascade do |t|
    t.uuid "supergenre_id", null: false
    t.uuid "subgenre_id", null: false
    t.index ["subgenre_id"], name: "index_genres_genres_on_subgenre_id"
    t.index ["supergenre_id"], name: "index_genres_genres_on_supergenre_id"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "alt_names", default: [], null: false
    t.string "status", null: false
    t.string "country", null: false
    t.string "description"
    t.date "formed_on"
    t.string "metal_archives_key"
    t.string "musicbrainz_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "synced_at"
    t.index ["metal_archives_key"], name: "index_groups_on_metal_archives_key", unique: true
    t.index ["musicbrainz_key"], name: "index_groups_on_musicbrainz_key", unique: true
  end

  create_table "groups_genres", id: false, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "genre_id", null: false
    t.index ["genre_id"], name: "index_groups_genres_on_genre_id"
    t.index ["group_id", "genre_id"], name: "index_groups_genres_on_group_id_and_genre_id", unique: true
    t.index ["group_id"], name: "index_groups_genres_on_group_id"
  end

  create_table "groups_releases", id: false, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "release_id", null: false
    t.index ["group_id", "release_id"], name: "index_groups_releases_on_group_id_and_release_id", unique: true
    t.index ["group_id"], name: "index_groups_releases_on_group_id"
    t.index ["release_id"], name: "index_groups_releases_on_release_id"
  end

  create_table "groups_themes", id: false, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "theme_id", null: false
    t.index ["group_id", "theme_id"], name: "index_groups_themes_on_group_id_and_theme_id", unique: true
    t.index ["group_id"], name: "index_groups_themes_on_group_id"
    t.index ["theme_id"], name: "index_groups_themes_on_theme_id"
  end

  create_table "pg_search_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.uuid "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "rateable_type", null: false
    t.uuid "rateable_id", null: false
    t.string "rating", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id"
    t.index ["user_id", "rateable_id", "rateable_type"], name: "index_ratings_on_user_id_and_rateable_id_and_rateable_type", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "recommendations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "recommended_type", null: false
    t.uuid "recommended_id", null: false
    t.string "reason", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recommended_type", "recommended_id"], name: "index_recommendations_on_type_and_id"
    t.index ["user_id", "recommended_id", "recommended_type"], name: "index_recommendations_on_user_id_and_id_and_type", unique: true
    t.index ["user_id"], name: "index_recommendations_on_user_id"
  end

  create_table "releases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.date "released_at"
    t.string "metal_archives_key"
    t.string "musicbrainz_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "synced_at"
    t.index ["metal_archives_key"], name: "index_releases_on_metal_archives_key", unique: true
    t.index ["musicbrainz_key"], name: "index_releases_on_musicbrainz_key", unique: true
  end

  create_table "themes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_themes_on_name", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "country", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.string "role", default: "user", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "artists_groups", "artists", on_delete: :cascade
  add_foreign_key "artists_groups", "groups", on_delete: :cascade
  add_foreign_key "artists_releases", "artists", on_delete: :cascade
  add_foreign_key "artists_releases", "releases", on_delete: :cascade
  add_foreign_key "genres_genres", "genres", column: "subgenre_id", on_delete: :cascade
  add_foreign_key "genres_genres", "genres", column: "supergenre_id", on_delete: :cascade
  add_foreign_key "groups_genres", "genres", on_delete: :cascade
  add_foreign_key "groups_genres", "groups", on_delete: :cascade
  add_foreign_key "groups_releases", "groups", on_delete: :cascade
  add_foreign_key "groups_releases", "releases", on_delete: :cascade
  add_foreign_key "groups_themes", "groups", on_delete: :cascade
  add_foreign_key "groups_themes", "themes", on_delete: :cascade
  add_foreign_key "ratings", "users", on_delete: :cascade
  add_foreign_key "recommendations", "users", on_delete: :cascade
end
