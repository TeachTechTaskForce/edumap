# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160113044412) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "standards_id"
  end

  add_index "codes", ["standards_id"], name: "index_codes_on_standards_id", using: :btree

  create_table "codes_lessons", id: false, force: :cascade do |t|
    t.integer "codes_id"
    t.integer "lessons_id"
  end

  add_index "codes_lessons", ["codes_id"], name: "index_codes_lessons_on_codes_id", using: :btree
  add_index "codes_lessons", ["lessons_id"], name: "index_codes_lessons_on_lessons_id", using: :btree

  create_table "curriculums", force: :cascade do |t|
    t.string   "name"
    t.string   "curriculum_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.string   "lesson_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "curriculums_id"
  end

  add_index "lessons", ["curriculums_id"], name: "index_lessons_on_curriculums_id", using: :btree

  create_table "lessons_levels", id: false, force: :cascade do |t|
    t.integer "lessons_id"
    t.integer "levels_id"
  end

  add_index "lessons_levels", ["lessons_id"], name: "index_lessons_levels_on_lessons_id", using: :btree
  add_index "lessons_levels", ["levels_id"], name: "index_lessons_levels_on_levels_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "standards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
