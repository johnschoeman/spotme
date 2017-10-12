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

ActiveRecord::Schema.define(version: 20171012181359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "spots", force: :cascade do |t|
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "title"
    t.string "image_url"
    t.float "rating"
    t.float "price"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "number"
    t.index ["latitude", "longitude"], name: "index_spots_on_latitude_and_longitude"
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_url"
    t.string "fb_name"
    t.string "fb_id"
    t.string "email", null: false
    t.index ["fb_id"], name: "index_users_on_fb_id", unique: true
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "spots", "users"
end
