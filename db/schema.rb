# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160324173909) do

  create_table "ahoy_events", force: :cascade do |t|
    t.uuid     "visit_id",   limit: 16
    t.integer  "user_id"
    t.string   "name"
    t.text     "properties"
    t.datetime "time"
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.datetime "date"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"

  create_table "parts", force: :cascade do |t|
    t.integer  "part_number"
    t.string   "title"
    t.text     "content"
    t.integer  "book_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "goodreads_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "date"
    t.text     "content"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "visible_to_public", default: false
    t.boolean  "visible_to_users",  default: false
    t.integer  "book_part"
  end

  create_table "rankings", force: :cascade do |t|
    t.string   "name"
    t.text     "data_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",              default: false
    t.string   "activation_digest"
    t.boolean  "activated",          default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "vip",                default: false
    t.integer  "share_count",        default: 0
    t.string   "oauth_provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "facebook_id"
    t.string   "facebook_name"
    t.string   "facebook_image"
    t.boolean  "has_shared_website", default: false
    t.boolean  "has_shared_part_1",  default: false
    t.boolean  "has_shared_part_2",  default: false
    t.boolean  "has_shared_part_3",  default: false
    t.boolean  "has_shared_part_4",  default: false
    t.boolean  "has_shared_part_5",  default: false
    t.boolean  "has_shared_part_6",  default: false
    t.boolean  "has_shared_part_7",  default: false
    t.boolean  "has_shared_part_8",  default: false
    t.boolean  "has_shared_part_9",  default: false
    t.boolean  "has_shared_part_10", default: false
    t.boolean  "has_shared_part_11", default: false
    t.boolean  "has_shared_part_12", default: false
    t.boolean  "has_shared_part_13", default: false
    t.boolean  "has_shared_part_14", default: false
    t.boolean  "has_shared_book_1",  default: false
    t.boolean  "has_shared_book_2",  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "visits", force: :cascade do |t|
    t.uuid     "visitor_id",       limit: 16
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

end
