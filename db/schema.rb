# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160809185823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_artist_id"
    t.string   "image_url"
    t.string   "preview_url"
    t.string   "spotify_track_id"
    t.integer  "game_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["game_id"], name: "index_artists_on_game_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "artists"
    t.string   "init_player_slug"
    t.string   "guest_player_slug"
    t.string   "init_player_id"
    t.string   "guest_player_id"
    t.index ["guest_player_slug"], name: "index_games_on_guest_player_slug", using: :btree
    t.index ["init_player_slug"], name: "index_games_on_init_player_slug", using: :btree
  end

end
