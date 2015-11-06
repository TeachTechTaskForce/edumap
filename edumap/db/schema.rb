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

ActiveRecord::Schema.define(version: 20151030155107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.string   "name"
    t.integer  "standard_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "codes", ["standard_id"], name: "index_codes_on_standard_id", using: :btree

  create_table "curriculums", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "curriculum_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "lessons", ["curriculum_id"], name: "index_lessons_on_curriculum_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "proficiency_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "levels", ["proficiency_id"], name: "index_levels_on_proficiency_id", using: :btree

  create_table "proficiencies", force: :cascade do |t|
    t.string   "name"
    t.integer  "standard_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "proficiencies", ["standard_id"], name: "index_proficiencies_on_standard_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["code_id"], name: "index_results_on_code_id", using: :btree
  add_index "results", ["lesson_id"], name: "index_results_on_lesson_id", using: :btree

  create_table "standards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "curriculum_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "units", ["curriculum_id"], name: "index_units_on_curriculum_id", using: :btree

  add_foreign_key "codes", "standards"
  add_foreign_key "lessons", "curriculums"
  add_foreign_key "levels", "proficiencies"
  add_foreign_key "proficiencies", "standards"
  add_foreign_key "results", "codes"
  add_foreign_key "results", "lessons"
  add_foreign_key "units", "curriculums"
end
