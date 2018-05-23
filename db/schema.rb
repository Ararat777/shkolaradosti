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

ActiveRecord::Schema.define(version: 20180522220928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "title"
    t.string "adress"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cash_boxes", force: :cascade do |t|
    t.decimal "cash"
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_cash_boxes_on_branch_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "age"
    t.text "allergy"
    t.text "comment"
    t.bigint "branch_id"
    t.bigint "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_clients_on_branch_id"
    t.index ["discount_id"], name: "index_clients_on_discount_id"
  end

  create_table "consumptions", force: :cascade do |t|
    t.string "title"
    t.decimal "amount"
    t.text "comment"
    t.bigint "cash_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_id"], name: "index_consumptions_on_cash_box_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "title"
    t.integer "percent"
    t.boolean "active"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encashments", force: :cascade do |t|
    t.decimal "amount"
    t.text "comment"
    t.bigint "cash_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_id"], name: "index_encashments_on_cash_box_id"
  end

  create_table "foods", force: :cascade do |t|
    t.float "price"
    t.float "amount", default: 0.0
    t.integer "count_days", default: 0
    t.string "paid_days", default: "0"
    t.bigint "client_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_foods_on_client_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer "service"
    t.decimal "amount"
    t.integer "client"
    t.text "comment"
    t.bigint "cash_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_id"], name: "index_incomes_on_cash_box_id"
  end

  create_table "paid_services", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "service_id"
    t.bigint "client_id"
    t.text "comment"
    t.boolean "status", default: true
    t.float "amount", default: 0.0
    t.float "required_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_paid_services_on_client_id"
    t.index ["service_id"], name: "index_paid_services_on_service_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.boolean "active", default: true
    t.bigint "branch_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_services_on_branch_id"
  end

  create_table "single_discounts", force: :cascade do |t|
    t.string "title"
    t.integer "percent"
    t.integer "count"
    t.boolean "active"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "from_cashbox"
    t.integer "to_cashbox"
    t.decimal "amount"
    t.integer "status", default: 0
    t.integer "kind", default: 0
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "adress"
    t.boolean "admin", default: false
    t.bigint "role_id"
    t.bigint "branch_id"
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
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "visited_days", force: :cascade do |t|
    t.date "day"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_visited_days_on_client_id"
  end

end
