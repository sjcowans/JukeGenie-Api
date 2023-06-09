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

ActiveRecord::Schema[7.0].define(version: 2023_06_06_181320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "spotify_id"
    t.text "genres"
    t.integer "popularity"
    t.json "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlist_tracks", force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_playlist_tracks_on_playlist_id"
    t.index ["track_id"], name: "index_playlist_tracks_on_track_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.float "longitude"
    t.float "latitude"
    t.string "input_address"
    t.float "range", default: 0.0
    t.string "spotify_id"
    t.string "join_key"
    t.bigint "host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_playlists_on_host_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer "seed_type"
    t.string "request"
    t.string "track_artist"
    t.string "spotify_artist_id"
    t.string "spotify_track_id"
    t.bigint "user_id", null: false
    t.bigint "playlist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_suggestions_on_playlist_id"
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.string "spotify_id"
    t.integer "popularity"
    t.json "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_playlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "playlist_id", null: false
    t.boolean "dj", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_user_playlists_on_playlist_id"
    t.index ["user_id"], name: "index_user_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "token"
    t.string "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "playlist_tracks", "playlists"
  add_foreign_key "playlist_tracks", "tracks"
  add_foreign_key "playlists", "users", column: "host_id"
  add_foreign_key "suggestions", "playlists"
  add_foreign_key "suggestions", "users"
  add_foreign_key "user_playlists", "playlists"
  add_foreign_key "user_playlists", "users"
end
