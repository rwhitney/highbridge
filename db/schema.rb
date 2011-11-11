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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111111134150) do

  create_table "members", :force => true do |t|
    t.string   "full_name"
    t.string   "portable_name"
    t.integer  "portable_number"
    t.string   "street_address"
    t.string   "city"
    t.string   "zip"
    t.string   "area"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "cell_or_other_phone"
    t.string   "shirt_size"
    t.string   "status"
    t.string   "misc_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin_calendar",                        :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "training_level"
    t.boolean  "admin_root",                            :default => false
    t.boolean  "admin_hr",                              :default => false
    t.boolean  "visitor",                               :default => false
  end

  add_index "members", ["portable_name"], :name => "index_members_on_portable_name", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "shifts", :force => true do |t|
    t.date     "shiftdate"
    t.integer  "shiftnum"
    t.integer  "e1member_id"
    t.integer  "e2member_id"
    t.integer  "dmember_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
