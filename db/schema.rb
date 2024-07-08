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

ActiveRecord::Schema[7.1].define(version: 2024_07_08_162017) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "accessory_type"
    t.string "name"
    t.boolean "default"
    t.text "comments"
    t.integer "grinder_min"
    t.integer "grinder_max"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accessories_on_user_id"
  end

  create_table "coffee_varieties", force: :cascade do |t|
    t.bigint "coffee_id", null: false
    t.bigint "variety_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coffee_id"], name: "index_coffee_varieties_on_coffee_id"
    t.index ["variety_id"], name: "index_coffee_varieties_on_variety_id"
  end

  create_table "coffees", force: :cascade do |t|
    t.string "roaster"
    t.date "roasting_date"
    t.string "name"
    t.string "process"
    t.string "country"
    t.string "region"
    t.decimal "latitude"
    t.decimal "longitude"
    t.integer "altitude_low"
    t.integer "altitude_high"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extractions", force: :cascade do |t|
    t.string "brewing_method"
    t.bigint "coffee_id", null: false
    t.bigint "user_coffee_id", null: false
    t.bigint "user_id", null: false
    t.bigint "accessory_id", null: false
    t.decimal "weight_in"
    t.integer "water_temperature"
    t.integer "pre_infusion_time"
    t.decimal "bloom_weight"
    t.integer "extraction_time"
    t.decimal "weight_out"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_extractions_on_accessory_id"
    t.index ["coffee_id"], name: "index_extractions_on_coffee_id"
    t.index ["user_coffee_id"], name: "index_extractions_on_user_coffee_id"
    t.index ["user_id"], name: "index_extractions_on_user_id"
  end

  create_table "flavors", force: :cascade do |t|
    t.string "name"
    t.bigint "tasting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color_code"
    t.index ["tasting_id"], name: "index_flavors_on_tasting_id"
  end

  create_table "tastings", force: :cascade do |t|
    t.bigint "extraction_id", null: false
    t.bigint "user_id", null: false
    t.string "tasting_type"
    t.integer "rating"
    t.text "comment"
    t.integer "fragrance"
    t.integer "acidity"
    t.integer "flavor"
    t.integer "body"
    t.integer "aftertaste"
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extraction_id"], name: "index_tastings_on_extraction_id"
    t.index ["user_id"], name: "index_tastings_on_user_id"
  end

  create_table "user_coffees", force: :cascade do |t|
    t.integer "bag_weight"
    t.integer "weight_left"
    t.decimal "price"
    t.text "personal_notes"
    t.boolean "archived"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "coffee_id", null: false
    t.index ["coffee_id"], name: "index_user_coffees_on_coffee_id"
    t.index ["user_id"], name: "index_user_coffees_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "varieties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "species"
    t.string "url"
    t.text "description"
    t.string "subname"
  end

  add_foreign_key "accessories", "users"
  add_foreign_key "coffee_varieties", "coffees"
  add_foreign_key "coffee_varieties", "varieties"
  add_foreign_key "extractions", "accessories"
  add_foreign_key "extractions", "coffees"
  add_foreign_key "extractions", "user_coffees"
  add_foreign_key "extractions", "users"
  add_foreign_key "flavors", "tastings"
  add_foreign_key "tastings", "extractions"
  add_foreign_key "tastings", "users"
  add_foreign_key "user_coffees", "coffees"
  add_foreign_key "user_coffees", "users"
end
