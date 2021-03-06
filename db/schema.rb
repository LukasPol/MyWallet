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

ActiveRecord::Schema[7.0].define(version: 2022_07_13_130609) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "assets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "amount", default: 0
    t.float "average_price", default: 0.0
    t.uuid "stock_id", null: false
    t.uuid "user_id", null: false
    t.uuid "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_invested", default: 0.0
    t.index ["stock_id", "user_id", "wallet_id"], name: "index_assets_on_stock_id_and_user_id_and_wallet_id", unique: true
    t.index ["stock_id"], name: "index_assets_on_stock_id"
    t.index ["user_id"], name: "index_assets_on_user_id"
    t.index ["wallet_id"], name: "index_assets_on_wallet_id"
  end

  create_table "proceeds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "date", null: false
    t.float "value", null: false
    t.integer "amount", null: false
    t.integer "kind", null: false
    t.uuid "user_id", null: false
    t.uuid "stock_id", null: false
    t.uuid "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_proceeds_on_stock_id"
    t.index ["user_id"], name: "index_proceeds_on_user_id"
    t.index ["wallet_id"], name: "index_proceeds_on_wallet_id"
  end

  create_table "stocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.string "document"
    t.boolean "has_problem", default: false
  end

  create_table "tradings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "date", null: false
    t.float "value", null: false
    t.integer "amount", null: false
    t.integer "kind", default: 0, null: false
    t.uuid "user_id", null: false
    t.uuid "stock_id", null: false
    t.uuid "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_value"
    t.uuid "asset_id", null: false
    t.index ["asset_id"], name: "index_tradings_on_asset_id"
    t.index ["stock_id"], name: "index_tradings_on_stock_id"
    t.index ["user_id"], name: "index_tradings_on_user_id"
    t.index ["wallet_id"], name: "index_tradings_on_wallet_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "user_id"], name: "index_wallets_on_name_and_user_id", unique: true
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "assets", "stocks"
  add_foreign_key "assets", "users"
  add_foreign_key "assets", "wallets"
  add_foreign_key "proceeds", "stocks"
  add_foreign_key "proceeds", "users"
  add_foreign_key "proceeds", "wallets"
  add_foreign_key "tradings", "assets"
  add_foreign_key "tradings", "stocks"
  add_foreign_key "tradings", "users"
  add_foreign_key "tradings", "wallets"
  add_foreign_key "wallets", "users"
end
