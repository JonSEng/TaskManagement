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

ActiveRecord::Schema.define(version: 20140108022031) do

  create_table "subtasks", force: true do |t|
    t.string   "title",       default: ""
    t.string   "description",                 null: false
    t.boolean  "finished",    default: false
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subtasks_workers", force: true do |t|
    t.integer "subtask_id"
    t.integer "worker_id"
  end

  create_table "task_sessions", force: true do |t|
    t.datetime "date",                    null: false
    t.string   "title",                   null: false
    t.integer  "progress",   default: 0
    t.string   "admin",      default: ""
    t.string   "location",   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_sessions_workers", force: true do |t|
    t.integer "task_session_id"
    t.integer "worker_id"
  end

  create_table "task_templates", force: true do |t|
    t.datetime "date",                    null: false
    t.string   "title",                   null: false
    t.string   "created_by", default: ""
    t.string   "location",   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "title",                    default: "", null: false
    t.integer  "lead_worker_id",           default: -1
    t.string   "notes",                    default: "", null: false
    t.integer  "progress",                 default: 0,  null: false
    t.string   "workers_that_finished_me", default: ""
    t.integer  "task_session_id"
    t.integer  "task_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_workers",              default: 1
    t.integer  "max_workers",              default: 2
  end

  create_table "tasks_workers", force: true do |t|
    t.integer "task_id"
    t.integer "worker_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.string   "phone_number",        default: "",    null: false
    t.string   "first_name",          default: "",    null: false
    t.string   "last_name",           default: "",    null: false
    t.string   "picture",             default: "",    null: false
    t.boolean  "admin",               default: false, null: false
    t.datetime "remember_created_at"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "workers", force: true do |t|
    t.string "name",                      null: false
    t.string "phone_number", default: ""
  end

end
