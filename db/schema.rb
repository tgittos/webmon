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

ActiveRecord::Schema.define(version: 20151116031753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incident_tests", force: :cascade do |t|
    t.integer  "incident_id"
    t.integer  "test_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.integer  "site_id"
    t.datetime "cleared_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_healths", force: :cascade do |t|
    t.integer  "site_id"
    t.integer  "http_response"
    t.integer  "response_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "site_healths", ["site_id"], name: "index_site_healths_on_site_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active",     default: true
    t.integer  "user_id"
  end

  add_index "sites", ["user_id"], name: "index_sites_on_user_id", using: :btree

  create_table "test_results", force: :cascade do |t|
    t.boolean  "result"
    t.integer  "test_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "value"
  end

  add_index "test_results", ["test_id"], name: "index_test_results_on_test_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.string   "comparison"
    t.string   "content"
    t.integer  "site_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "active",            default: true
    t.string   "type"
    t.integer  "failure_threshold"
    t.integer  "clear_threshold"
  end

  add_index "tests", ["site_id"], name: "index_tests_on_site_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "app_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "site_healths", "sites"
  add_foreign_key "sites", "users"
  add_foreign_key "test_results", "tests"
  add_foreign_key "tests", "sites"
end
