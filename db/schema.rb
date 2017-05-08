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

ActiveRecord::Schema.define(version: 20170508023532) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "friendly_id"
    t.string   "status",      default: "draft"
    t.integer  "category_id"
    t.integer  "row_order"
    t.string   "logo"
    t.string   "images"
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["friendly_id"], name: "index_events_on_friendly_id", unique: true
    t.index ["row_order"], name: "index_events_on_row_order"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "legal_name"
    t.date     "birthday"
    t.string   "location"
    t.string   "education"
    t.string   "occupation"
    t.text     "bio"
    t.text     "specialty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "status",     default: "pending"
    t.string   "uuid"
    t.integer  "event_id"
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "cellphone"
    t.string   "website"
    t.text     "bio"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["event_id"], name: "index_registrations_on_event_id"
    t.index ["ticket_id"], name: "index_registrations_on_ticket_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
    t.index ["uuid"], name: "index_registrations_on_uuid", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "time_zone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                         null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 1073741823
    t.datetime "created_at"
    t.text     "object_changes", limit: 1073741823
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
