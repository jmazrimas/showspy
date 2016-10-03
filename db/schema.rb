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

ActiveRecord::Schema.define(version: 20161001140653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "artist"
    t.datetime "date"
    t.integer  "venue_id"
    t.integer  "user_id"
    t.integer  "match_level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "track_profiles", force: :cascade do |t|
    t.integer  "track_id"
    t.float    "danceability"
    t.float    "energy"
    t.float    "loudness"
    t.float    "mode"
    t.float    "speechiness"
    t.float    "acousticness"
    t.float    "instrumentalness"
    t.float    "liveness"
    t.float    "valence"
    t.float    "tempo"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string   "spotify_id"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "access_token"
    t.string   "refresh_token"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "jambase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
