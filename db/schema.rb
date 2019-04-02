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

ActiveRecord::Schema.define(version: 20190330173402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charts", force: :cascade do |t|
    t.string "name"
    t.string "metric"
    t.integer "default_duration"
    t.string "default_duration_unit"
    t.bigint "user_id"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_charts_on_device_id"
    t.index ["name"], name: "index_charts_on_name", unique: true
    t.index ["user_id"], name: "index_charts_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "turn_on_time"
    t.integer "turn_off_time"
    t.string "intensity"
    t.integer "on_temperature"
    t.integer "off_temperature"
    t.integer "on_volume"
    t.integer "off_volume"
    t.string "group"
    t.decimal "temperature_set"
    t.string "status"
    t.boolean "on"
    t.string "slug"
    t.decimal "distance"
    t.string "intensity_override"
    t.integer "valve_on_time"
    t.integer "valve_off_time"
    t.float "light_intensity_lvl"
    t.boolean "valve_on", default: false
    t.bigint "valve_controller_id"
    t.bigint "aquarium_controller_id"
    t.bigint "user_id"
    t.index ["aquarium_controller_id"], name: "index_devices_on_aquarium_controller_id"
    t.index ["authentication_token"], name: "index_devices_on_authentication_token", unique: true
    t.index ["name"], name: "index_devices_on_name", unique: true
    t.index ["reset_password_token"], name: "index_devices_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_devices_on_user_id"
    t.index ["valve_controller_id"], name: "index_devices_on_valve_controller_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "jwt_blacklist", id: :serial, force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "charts", "devices"
  add_foreign_key "charts", "users"
  add_foreign_key "devices", "users"
end
