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

ActiveRecord::Schema.define(version: 20170216122336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "type_money"
    t.integer  "client_id"
    t.index ["client_id"], name: "index_accounts_on_client_id", using: :btree
  end

  create_table "actions", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "country"
    t.string   "full_address"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "bank_id"
    t.string   "bank_account_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["account_id"], name: "index_bank_accounts_on_account_id", using: :btree
    t.index ["bank_id"], name: "index_bank_accounts_on_bank_id", using: :btree
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.string   "plugin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "address_id"
    t.index ["account_id"], name: "index_clients_on_account_id", using: :btree
    t.index ["address_id"], name: "index_clients_on_address_id", using: :btree
    t.index ["confirmation_token"], name: "index_clients_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_clients_on_email", unique: true, using: :btree
    t.index ["entity_type", "entity_id"], name: "index_clients_on_entity_type_and_entity_id", using: :btree
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_clients_on_role_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "type"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
    t.index ["client_id"], name: "index_contacts_on_client_id", using: :btree
  end

  create_table "corporate_individuals", force: :cascade do |t|
    t.integer  "corporate_id"
    t.integer  "individual_id"
    t.integer  "employee_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["corporate_id"], name: "index_corporate_individuals_on_corporate_id", using: :btree
    t.index ["employee_id"], name: "index_corporate_individuals_on_employee_id", using: :btree
    t.index ["individual_id"], name: "index_corporate_individuals_on_individual_id", using: :btree
  end

  create_table "corporates", force: :cascade do |t|
    t.string   "registration_number"
    t.string   "in"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "full_name"
    t.string   "legal_form"
    t.string   "okpo"
  end

  create_table "correspondent_accounts", force: :cascade do |t|
    t.decimal  "balance"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "operation_id"
    t.index ["operation_id"], name: "index_correspondent_accounts_on_operation_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "agent_id"
    t.string   "client_id"
    t.string   "account_id"
    t.decimal  "sum"
    t.string   "target"
    t.string   "status",       default: "new"
    t.string   "doc_type"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "operation_id"
    t.index ["operation_id"], name: "index_documents_on_operation_id", using: :btree
  end

  create_table "draft_phone_registrations", force: :cascade do |t|
    t.string   "phone"
    t.datetime "end_of_ban"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "in"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "operations", force: :cascade do |t|
    t.string   "description"
    t.string   "status"
    t.string   "fold"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "otp_registrations", force: :cascade do |t|
    t.integer  "draft_phone_registration_id"
    t.string   "pin"
    t.integer  "try_count"
    t.boolean  "succeeded"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["draft_phone_registration_id"], name: "index_otp_registrations_on_draft_phone_registration_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "definition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "permission"
  end

  create_table "roles_actions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "action_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_roles_actions_on_action_id", using: :btree
    t.index ["role_id"], name: "index_roles_actions_on_role_id", using: :btree
  end

  create_table "wallet_balances", force: :cascade do |t|
    t.decimal  "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_wallet_balances_on_account_id", using: :btree
  end

  add_foreign_key "accounts", "clients"
  add_foreign_key "bank_accounts", "accounts"
  add_foreign_key "bank_accounts", "banks"
  add_foreign_key "clients", "accounts"
  add_foreign_key "clients", "addresses"
  add_foreign_key "clients", "roles"
  add_foreign_key "contacts", "clients"
  add_foreign_key "corporate_individuals", "corporates"
  add_foreign_key "corporate_individuals", "employees"
  add_foreign_key "corporate_individuals", "individuals"
  add_foreign_key "correspondent_accounts", "operations"
  add_foreign_key "documents", "operations"
  add_foreign_key "otp_registrations", "draft_phone_registrations"
  add_foreign_key "roles_actions", "actions"
  add_foreign_key "roles_actions", "roles"
  add_foreign_key "wallet_balances", "accounts"
end
