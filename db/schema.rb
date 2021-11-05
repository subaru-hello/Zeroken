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

ActiveRecord::Schema.define(version: 2021_10_26_092517) do

  create_table "alcohol_orders", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "analyze_id"
    t.bigint "alcohol_id"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alcohol_id"], name: "index_alcohol_orders_on_alcohol_id"
    t.index ["analyze_id"], name: "index_alcohol_orders_on_analyze_id"
  end

  create_table "alcohols", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.integer "alcohol_percentage"
    t.integer "alcohol_amount"
    t.integer "pure_alcohol_intake"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "analyzes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "total_points"
    t.integer "sake_strongness_types", default: 0, null: false
    t.integer "next_nomivation_types", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_analyzes_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "nickname"
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "analyzes", "users"
end
