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

ActiveRecord::Schema.define(version: 20170124095620) do

  create_table "accounts", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "actions", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "mobile"
    t.string   "country"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "account_id"
    t.integer  "role_id"
    t.string   "entity_type"
    t.integer  "entity_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "individual_type"
    t.integer  "individual_id"
    t.index ["account_id"], name: "index_clients_on_account_id"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["entity_type", "entity_id"], name: "index_clients_on_entity_type_and_entity_id"
    t.index ["individual_type", "individual_id"], name: "index_clients_on_individual_type_and_individual_id"
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_clients_on_role_id"
  end

  create_table "corporate_individuals", force: :cascade do |t|
    t.integer  "corporate_id"
    t.integer  "individual_id"
    t.integer  "employee_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["corporate_id"], name: "index_corporate_individuals_on_corporate_id"
    t.index ["employee_id"], name: "index_corporate_individuals_on_employee_id"
    t.index ["individual_id"], name: "index_corporate_individuals_on_individual_id"
  end

  create_table "corporates", force: :cascade do |t|
    t.string   "registration_number"
    t.string   "bin"
    t.string   "address"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individuals", force: :cascade do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.date     "dob"
    t.string   "inn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "definition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_actions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "action_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_roles_actions_on_action_id"
    t.index ["role_id"], name: "index_roles_actions_on_role_id"
  end

end

load "#{Rails.root}/db/seeds.rb"