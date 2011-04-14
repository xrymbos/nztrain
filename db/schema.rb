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

ActiveRecord::Schema.define(:version => 20110414074435) do

  create_table "groups", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      :default => "Untitled Group", :null => false
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "user_id",  :null => false
  end

  create_table "problems", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "statement",                     :null => false
    t.string   "input",                         :null => false
    t.string   "output",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "memory_limit", :default => 32,  :null => false
    t.decimal  "time_limit",   :default => 1.0, :null => false
  end

  create_table "submissions", :force => true do |t|
    t.text     "source",     :null => false
    t.string   "language",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id", :null => false
    t.integer  "user_id",    :null => false
    t.integer  "score"
  end

  create_table "test_cases", :force => true do |t|
    t.integer  "problem_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "input",                      :null => false
    t.text     "output",                     :null => false
    t.integer  "points",     :default => 10, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
