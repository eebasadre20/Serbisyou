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

ActiveRecord::Schema.define(version: 20150202111824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authenticates", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barangays", force: true do |t|
    t.string   "barangay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brgy_avatars", force: true do |t|
    t.string   "name"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brgyadmins", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "barangay"
    t.string   "brgy_position"
    t.string   "contact_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "role",               default: "BrgyAdmin"
    t.integer  "brgy_avatar_id"
  end

  add_index "brgyadmins", ["brgy_avatar_id"], name: "index_brgyadmins_on_brgy_avatar_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
    t.integer  "barangay_id"
  end

  add_index "categories", ["barangay_id"], name: "index_categories_on_barangay_id", using: :btree
  add_index "categories", ["service_id"], name: "index_categories_on_service_id", using: :btree

  create_table "categorizations", force: true do |t|
    t.integer  "service_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "serviceprovider_id"
    t.integer  "primary_skillset_id"
  end

  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["primary_skillset_id"], name: "index_categorizations_on_primary_skillset_id", using: :btree
  add_index "categorizations", ["service_id"], name: "index_categorizations_on_service_id", using: :btree
  add_index "categorizations", ["serviceprovider_id"], name: "index_categorizations_on_serviceprovider_id", using: :btree

  create_table "clearances", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clearanceships", force: true do |t|
    t.integer  "serviceprovider_id"
    t.integer  "clearance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clearanceships", ["clearance_id"], name: "index_clearanceships_on_clearance_id", using: :btree
  add_index "clearanceships", ["serviceprovider_id"], name: "index_clearanceships_on_serviceprovider_id", using: :btree

  create_table "primary_skillsets", force: true do |t|
    t.integer  "service_id"
    t.integer  "serviceprovider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "primary_skillsets", ["service_id"], name: "index_primary_skillsets_on_service_id", using: :btree
  add_index "primary_skillsets", ["serviceprovider_id"], name: "index_primary_skillsets_on_serviceprovider_id", using: :btree

  create_table "rs_reputations", force: true do |t|
    t.string   "reputation_name"
    t.float    "value",           default: 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true, using: :btree
  add_index "rs_reputations", ["reputation_name"], name: "index_rs_reputations_on_reputation_name", using: :btree
  add_index "rs_reputations", ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type", using: :btree

  create_table "serviceproviders", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthdate"
    t.string   "gender"
    t.string   "civil_status"
    t.string   "barangay"
    t.string   "brgy_address"
    t.string   "contact_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "brgyadmin_id"
    t.string   "avatar"
    t.string   "username"
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.integer  "barangay_id"
    t.integer  "service_id"
    t.integer  "category_id"
    t.integer  "authenticate_id"
    t.string   "role",               default: "ServiceProvider"
  end

  add_index "serviceproviders", ["authenticate_id"], name: "index_serviceproviders_on_authenticate_id", using: :btree
  add_index "serviceproviders", ["barangay_id"], name: "index_serviceproviders_on_barangay_id", using: :btree
  add_index "serviceproviders", ["brgyadmin_id"], name: "index_serviceproviders_on_brgyadmin_id", using: :btree
  add_index "serviceproviders", ["category_id"], name: "index_serviceproviders_on_category_id", using: :btree
  add_index "serviceproviders", ["service_id"], name: "index_serviceproviders_on_service_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "service"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "service_keyword"
  end

  create_table "taggings", force: true do |t|
    t.integer  "category_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["category_id"], name: "index_taggings_on_category_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "contact_number"
    t.string   "barangay"
    t.string   "brgy_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "role",               default: "Client"
  end

  create_table "usersessions", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
