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

ActiveRecord::Schema.define(:version => 20130724074815) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "location"
    t.integer  "region_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hotel_services", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "service_type_id"
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "hotels", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "location"
    t.integer  "city_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "nodes", :force => true do |t|
    t.integer  "parent"
    t.string   "name"
    t.string   "title"
    t.string   "header"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "periods", :force => true do |t|
    t.date     "since"
    t.date     "till"
    t.string   "name"
    t.string   "description"
    t.integer  "order_position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "hotel_id"
  end

  create_table "regions", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "room_prices", :force => true do |t|
    t.integer  "room_id"
    t.integer  "period_id"
    t.integer  "value"
    t.integer  "measure_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rooms", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "service_type_id"
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "source_classes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "parent_class_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "source_instances", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "source_class_id"
    t.integer  "parent_instance_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "phone"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username"

end
