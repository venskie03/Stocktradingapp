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

ActiveRecord::Schema[7.1].define(version: 2024_01_10_123047) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stock_id"
    t.integer "transaction_type"
    t.decimal "price", precision: 8, scale: 2
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_orders_on_stock_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "ticker"
    t.string "company_name"
    t.decimal "last_transaction_price", precision: 8, scale: 2
    t.integer "quantity"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_name"], name: "index_stocks_on_company_name"
    t.index ["ticker"], name: "index_stocks_on_ticker", unique: true
  end

  create_table "transaction_records", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.decimal "price", precision: 8, scale: 2
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_transaction_records_on_buyer_id"
    t.index ["seller_id"], name: "index_transaction_records_on_seller_id"
    t.index ["stock_id"], name: "index_transaction_records_on_stock_id"
  end

  create_table "user_stocks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stock_id"
    t.decimal "average_price", precision: 8, scale: 2, default: "0.0"
    t.integer "total_shares", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_user_stocks_on_stock_id"
    t.index ["user_id"], name: "index_user_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "balance", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "transaction_records", "stocks"
  add_foreign_key "transaction_records", "users", column: "buyer_id"
  add_foreign_key "transaction_records", "users", column: "seller_id"
end
