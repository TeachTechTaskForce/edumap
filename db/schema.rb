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

ActiveRecord::Schema.define(version: 20160316013637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.string   "identifier"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "standard_id"
  end

  add_index "codes", ["standard_id"], name: "index_codes_on_standard_id", using: :btree

  create_table "codes_lessons", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "lesson_id"
  end

  add_index "codes_lessons", ["code_id"], name: "index_codes_lessons_on_code_id", using: :btree
  add_index "codes_lessons", ["lesson_id"], name: "index_codes_lessons_on_lesson_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.text     "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "curriculums", force: :cascade do |t|
    t.string   "name"
    t.string   "curriculum_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.string   "lesson_url"
    t.string   "time"
    t.text     "description"
    t.boolean  "plugged?",      default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "curriculum_id"
  end

  add_index "lessons", ["curriculum_id"], name: "index_lessons_on_curriculum_id", using: :btree

  create_table "lessons_levels", id: false, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "level_id"
  end

  add_index "lessons_levels", ["lesson_id"], name: "index_lessons_levels_on_lesson_id", using: :btree
  add_index "lessons_levels", ["level_id"], name: "index_lessons_levels_on_level_id", using: :btree

  create_table "lessons_standards", id: false, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "standard_id"
  end

  add_index "lessons_standards", ["lesson_id"], name: "index_lessons_standards_on_lesson_id", using: :btree
  add_index "lessons_standards", ["standard_id"], name: "index_lessons_standards_on_standard_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "grade"
  end

  create_table "standards", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
