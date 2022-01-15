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

ActiveRecord::Schema.define(version: 2022_01_15_141921) do

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alcohol_in_veins", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "analyze_results_id"
    t.integer "total_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["analyze_results_id"], name: "index_alcohol_in_veins_on_analyze_results_id"
  end

  create_table "alcohols", charset: "utf8mb4", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.float "alcohol_percentage"
    t.integer "alcohol_amount"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

  create_table "analyze_results", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "total_points"
    t.integer "alcohol_strongness", default: 0
    t.integer "total_alcohol_amounts", default: 0
    t.integer "alcohol_first"
    t.integer "alcohol_second"
    t.integer "alcohol_third"
    t.integer "alcohol_forth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_analyze_results_on_user_id"
  end

  create_table "analyzes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "total_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.integer "shuchedule"
    t.integer "next_motivation", default: 0
    t.integer "alcohol_strongness", default: 0
    t.index ["user_id"], name: "index_analyzes_on_user_id"
  end

  create_table "answers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "questions_id"
    t.integer "point"
    t.string "choice"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["questions_id"], name: "index_answers_on_questions_id"
  end

  create_table "api_keys", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "access_token", null: false
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_token"], name: "index_api_keys_on_access_token", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "descriptions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "analyze_results_id"
    t.integer "explanation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["analyze_results_id"], name: "index_descriptions_on_analyze_results_id"
  end

  create_table "favorites", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "users_id"
    t.bigint "alcohols_id"
    t.index ["alcohols_id"], name: "index_favorites_on_alcohols_id"
    t.index ["users_id"], name: "index_favorites_on_users_id"
  end

  create_table "questions", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "not_answered"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "nickname", limit: 191
    t.string "email", limit: 191, null: false
    t.string "crypted_password", limit: 191
    t.string "salt", limit: 191
    t.integer "role", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alcohol_in_veins", "analyze_results", column: "analyze_results_id"
  add_foreign_key "analyze_results", "users"
  add_foreign_key "analyzes", "users"
  add_foreign_key "answers", "questions", column: "questions_id"
  add_foreign_key "api_keys", "users"
  add_foreign_key "descriptions", "analyze_results", column: "analyze_results_id"
  add_foreign_key "favorites", "alcohols", column: "alcohols_id"
  add_foreign_key "favorites", "users", column: "users_id"
end
