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

ActiveRecord::Schema[7.1].define(version: 2024_03_12_110416) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "lectures", force: :cascade do |t|
    t.string "room"
    t.string "teacher"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "day"
    t.float "length"
    t.string "lecture_type"
    t.boolean "is_stacked", default: false
    t.boolean "is_checked", default: true
    t.string "predmet_name"
    t.bigint "user_id", null: false
    t.string "color"
    t.index ["user_id"], name: "index_lectures_on_user_id"
  end

  create_table "predmets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "adbreviation"
    t.text "status"
    t.text "teacher"
    t.string "color"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_predmets_on_user_id"
  end

  create_table "timetable_predmets", force: :cascade do |t|
    t.bigint "user_timetable_id", null: false
    t.bigint "predmet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["predmet_id"], name: "index_timetable_predmets_on_predmet_id"
    t.index ["user_timetable_id"], name: "index_timetable_predmets_on_user_timetable_id"
  end

  create_table "user_predmets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "predmet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["predmet_id"], name: "index_user_predmets_on_predmet_id"
    t.index ["user_id"], name: "index_user_predmets_on_user_id"
  end

  create_table "user_timetables", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_timetables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "lectures", "users"
  add_foreign_key "predmets", "users"
  add_foreign_key "timetable_predmets", "predmets"
  add_foreign_key "timetable_predmets", "user_timetables"
  add_foreign_key "user_predmets", "predmets"
  add_foreign_key "user_predmets", "users"
  add_foreign_key "user_timetables", "users"
end
