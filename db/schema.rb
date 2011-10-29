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

ActiveRecord::Schema.define(:version => 20111028153533) do

  create_table "members", :force => true do |t|
    t.string   "fullname"
    t.string   "portablename"
    t.integer  "portablenumber"
    t.string   "email"
    t.string   "privilege"
    t.string   "streetaddress"
    t.string   "city"
    t.string   "zip"
    t.string   "area"
    t.string   "homephone"
    t.string   "workphone"
    t.string   "cellorotherphone"
    t.string   "shirtsize"
    t.string   "status"
    t.string   "miscnotes"
    t.string   "password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
