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

ActiveRecord::Schema.define(version: 20160115131602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "system_id"
    t.integer  "resource_id"
    t.integer  "status"
    t.integer  "log_type"
    t.text     "message"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "parameters"
    t.text     "exception"
  end

  add_index "logs", ["account_id"], name: "index_logs_on_account_id", using: :btree
  add_index "logs", ["resource_id"], name: "index_logs_on_resource_id", using: :btree
  add_index "logs", ["system_id"], name: "index_logs_on_system_id", using: :btree

  create_table "resource_classes", force: :cascade do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "resource_classes", ["account_id"], name: "index_resource_classes_on_account_id", using: :btree

  create_table "resource_objects", force: :cascade do |t|
    t.integer  "resource_id", null: false
    t.integer  "object_ref",  null: false
    t.integer  "system_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_objects", ["resource_id", "object_ref", "system_id"], name: "resource_objects_unique_idx", unique: true, using: :btree
  add_index "resource_objects", ["resource_id"], name: "index_resource_objects_on_resource_id", using: :btree
  add_index "resource_objects", ["system_id"], name: "index_resource_objects_on_system_id", using: :btree

  create_table "resource_types", force: :cascade do |t|
    t.integer  "resource_class_id"
    t.string   "url"
    t.integer  "account_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "resource_types", ["account_id"], name: "index_resource_types_on_account_id", using: :btree
  add_index "resource_types", ["resource_class_id"], name: "index_resource_types_on_resource_class_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.integer "resource_type_id"
  end

  add_index "resources", ["resource_type_id"], name: "index_resources_on_resource_type_id", using: :btree

  create_table "systems", force: :cascade do |t|
    t.string   "description"
    t.string   "api_url"
    t.string   "token"
    t.integer  "account_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "systems", ["token"], name: "index_systems_on_token", unique: true, using: :btree

  add_foreign_key "logs", "accounts"
  add_foreign_key "logs", "resources"
  add_foreign_key "logs", "systems"
  add_foreign_key "resource_classes", "accounts"
  add_foreign_key "resource_objects", "resources"
  add_foreign_key "resource_objects", "systems"
  add_foreign_key "resource_types", "accounts"
  add_foreign_key "resource_types", "resource_classes"
  add_foreign_key "resources", "resource_types"
end
