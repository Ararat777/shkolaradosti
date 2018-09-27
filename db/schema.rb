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

ActiveRecord::Schema.define(version: 20180921163135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "title"
    t.string "adress"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cash_box_sessions", force: :cascade do |t|
    t.datetime "closed_at"
    t.bigint "cash_box_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_id"], name: "index_cash_box_sessions_on_cash_box_id"
  end

  create_table "cash_box_sessions_transfers", id: false, force: :cascade do |t|
    t.bigint "cash_box_session_id"
    t.bigint "transfer_id"
    t.index ["cash_box_session_id"], name: "index_cash_box_sessions_transfers_on_cash_box_session_id"
    t.index ["transfer_id"], name: "index_cash_box_sessions_transfers_on_transfer_id"
  end

  create_table "cash_boxes", force: :cascade do |t|
    t.decimal "cash", default: "0.0"
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
    t.bigint "parent_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_clients_on_branch_id"
    t.index ["discount_id"], name: "index_clients_on_discount_id"
    t.index ["parent_id"], name: "index_clients_on_parent_id"
  end

  create_table "consumptions", force: :cascade do |t|
    t.string "title"
    t.float "amount"
    t.text "comment"
    t.bigint "cash_box_session_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_session_id"], name: "index_consumptions_on_cash_box_session_id"
  end

  create_table "days_counts", force: :cascade do |t|
    t.integer "count_days"
    t.integer "current_count_days"
    t.bigint "paid_service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paid_service_id"], name: "index_days_counts_on_paid_service_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "title"
    t.integer "discount_size"
    t.boolean "active", default: true
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encashments", force: :cascade do |t|
    t.float "amount"
    t.text "comment"
    t.bigint "cash_box_session_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_session_id"], name: "index_encashments_on_cash_box_session_id"
  end

  create_table "exceptional_days", force: :cascade do |t|
    t.string "title"
    t.date "day"
    t.boolean "is_holiday"
    t.bigint "month_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month_id"], name: "index_exceptional_days_on_month_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.string "acceptor"
    t.string "title"
    t.float "amount"
    t.text "comment"
    t.integer "client_id"
    t.integer "service_id"
    t.bigint "cash_box_session_id"
    t.bigint "paid_period_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cash_box_session_id"], name: "index_incomes_on_cash_box_session_id"
    t.index ["paid_period_id"], name: "index_incomes_on_paid_period_id"
  end

  create_table "inventory_categories", force: :cascade do |t|
    t.string "title"
    t.integer "size"
    t.bigint "branch_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_inventory_categories_on_branch_id"
  end

  create_table "inventory_categories_transfers", id: false, force: :cascade do |t|
    t.bigint "inventory_category_id"
    t.bigint "inventory_transfer_id"
    t.index ["inventory_category_id"], name: "index_inventory_categories_transfers_on_inventory_category_id"
    t.index ["inventory_transfer_id"], name: "index_inventory_categories_transfers_on_inventory_transfer_id"
  end

  create_table "inventory_transfers", force: :cascade do |t|
    t.integer "from_branch"
    t.integer "to_branch"
    t.string "inventory_category_title"
    t.integer "size"
    t.integer "status", default: 0
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "months", force: :cascade do |t|
    t.string "title"
    t.integer "number"
    t.integer "year"
    t.integer "work_days_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paid_periods", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.float "required_amount"
    t.float "paid_amount"
    t.float "lack", default: 0.0
    t.float "countable_balance"
    t.boolean "active"
    t.integer "total_paid_days_size"
    t.integer "rest_paid_days_size"
    t.bigint "paid_service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paid_service_id"], name: "index_paid_periods_on_paid_service_id"
  end

  create_table "paid_services", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "client_id"
    t.bigint "single_discount_id"
    t.text "comment"
    t.float "total_required_amount"
    t.float "total_lack"
    t.float "total_paid_amount"
    t.datetime "canceled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_paid_services_on_client_id"
    t.index ["service_id"], name: "index_paid_services_on_service_id"
    t.index ["single_discount_id"], name: "index_paid_services_on_single_discount_id"
  end

  create_table "parents", force: :cascade do |t|
    t.string "father_name"
    t.string "father_phone"
    t.string "father_additional_phone"
    t.string "father_adress"
    t.string "father_work_adress"
    t.date "father_birthdate"
    t.string "father_email"
    t.string "mother_name"
    t.string "mother_phone"
    t.string "mother_additional_phone"
    t.string "mother_adress"
    t.string "mother_work_adress"
    t.date "mother_birthdate"
    t.string "mother_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string "title"
    t.string "path"
    t.string "reportable_type"
    t.bigint "reportable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable_type_and_reportable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.boolean "countable", default: false
    t.boolean "active", default: true
    t.bigint "branch_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_services_on_branch_id"
  end

  create_table "single_discounts", force: :cascade do |t|
    t.string "title"
    t.integer "discount_size"
    t.integer "count"
    t.boolean "fixed"
    t.boolean "active", default: true
    t.bigint "branch_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_single_discounts_on_branch_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "from_cashbox"
    t.integer "to_cashbox"
    t.float "amount"
    t.integer "status", default: 0
    t.integer "kind", default: 0
    t.text "comment"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "adress"
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
