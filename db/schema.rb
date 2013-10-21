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

ActiveRecord::Schema.define(version: 20131021181745) do

  create_table "hackday_organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hackdays", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "hackday_organization_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hackdays", ["hackday_organization_id"], name: "index_hackdays_on_hackday_organization_id", using: :btree

  create_table "hardwares", force: true do |t|
    t.string   "name"
    t.integer  "hackday_organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hardwares", ["hackday_organization_id"], name: "index_hardwares_on_hackday_organization_id", using: :btree

  create_table "hardwares_hackdays", force: true do |t|
    t.integer  "hardware_id"
    t.integer  "hackday_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hardwares_hackdays", ["hackday_id"], name: "index_hardwares_hackdays_on_hackday_id", using: :btree
  add_index "hardwares_hackdays", ["hardware_id"], name: "index_hardwares_hackdays_on_hardware_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hackday_id"
  end

  add_index "projects", ["hackday_id"], name: "index_projects_on_hackday_id", using: :btree

  create_table "projects_hardwares", force: true do |t|
    t.integer  "project_id"
    t.integer  "hardware_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects_hardwares", ["hardware_id"], name: "index_projects_hardwares_on_hardware_id", using: :btree
  add_index "projects_hardwares", ["project_id"], name: "index_projects_hardwares_on_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  create_table "users_hackday_organizations", force: true do |t|
    t.integer  "user_id"
    t.integer  "hackday_organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_hackday_organizations", ["hackday_organization_id"], name: "index_users_hackday_organizations_on_hackday_organization_id", using: :btree
  add_index "users_hackday_organizations", ["user_id"], name: "index_users_hackday_organizations_on_user_id", using: :btree

end
