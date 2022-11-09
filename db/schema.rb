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

ActiveRecord::Schema[7.0].define(version: 2022_11_08_210843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "uuid"
    t.string "first_name"
    t.string "last_name"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_drivers_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.uuid "uuid"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id"
    t.index ["user_id"], name: "index_organizations_users_on_user_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "uuid"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer "travel_time"
    t.integer "total_stops"
    t.string "action"
    t.bigint "organization_id", null: false
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_routes_on_organization_id"
    t.index ["vehicle_id"], name: "index_routes_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "national_id"
    t.uuid "uuid"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "uuid"
    t.string "plate"
    t.bigint "organization_id", null: false
    t.bigint "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_vehicles_on_driver_id"
    t.index ["organization_id"], name: "index_vehicles_on_organization_id"
  end

  add_foreign_key "drivers", "organizations"
  add_foreign_key "routes", "organizations"
  add_foreign_key "routes", "vehicles"
  add_foreign_key "vehicles", "drivers"
  add_foreign_key "vehicles", "organizations"
end
