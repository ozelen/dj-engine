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

ActiveRecord::Schema.define(:version => 20130818165236) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "assigned_id"
    t.string   "assigned_type"
    t.string   "role"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "assignments", ["assigned_id", "assigned_type"], :name => "index_assignments_on_assigned_id_and_assigned_type"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "location"
    t.integer  "region_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "city_translations", :force => true do |t|
    t.integer  "city_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "city_translations", ["city_id"], :name => "index_city_translations_on_city_id"
  add_index "city_translations", ["locale"], :name => "index_city_translations_on_locale"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "field_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "type_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "field_categories", ["type_id"], :name => "index_field_categories_on_type_id"

  create_table "field_category_translations", :force => true do |t|
    t.integer  "field_category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "field_category_translations", ["field_category_id"], :name => "index_field_category_translations_on_field_category_id"
  add_index "field_category_translations", ["locale"], :name => "index_field_category_translations_on_locale"

  create_table "field_translations", :force => true do |t|
    t.integer  "field_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "field_translations", ["field_id"], :name => "index_field_translations_on_field_id"
  add_index "field_translations", ["locale"], :name => "index_field_translations_on_locale"

  create_table "fields", :force => true do |t|
    t.string   "name"
    t.integer  "measure_category_id"
    t.boolean  "required"
    t.integer  "type_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "slug"
    t.integer  "field_category_id"
  end

  add_index "fields", ["field_category_id"], :name => "index_fields_on_field_category_id"
  add_index "fields", ["measure_category_id"], :name => "index_fields_on_measure_category_id"
  add_index "fields", ["type_id"], :name => "index_fields_on_type_id"

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cover_photo_id"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "galleries", ["imageable_id", "imageable_type"], :name => "index_galleries_on_imageable_id_and_imageable_type"

  create_table "hotel_translations", :force => true do |t|
    t.integer  "hotel_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "hotel_translations", ["hotel_id"], :name => "index_hotel_translations_on_hotel_id"
  add_index "hotel_translations", ["locale"], :name => "index_hotel_translations_on_locale"

  create_table "hotels", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "location"
    t.integer  "city_id"
    t.integer  "user_id"
    t.string   "ident"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "type_id"
  end

  add_index "hotels", ["city_id"], :name => "index_hotels_on_city_id"
  add_index "hotels", ["type_id"], :name => "index_hotels_on_type_id"
  add_index "hotels", ["user_id"], :name => "index_hotels_on_user_id"

  create_table "measure_categories", :force => true do |t|
    t.string   "name"
    t.integer  "data_type"
    t.string   "filter"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "measure_category_translations", :force => true do |t|
    t.integer  "measure_category_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "measure_category_translations", ["locale"], :name => "index_measure_category_translations_on_locale"
  add_index "measure_category_translations", ["measure_category_id"], :name => "index_measure_category_translations_on_measure_category_id"

  create_table "measure_translations", :force => true do |t|
    t.integer  "measure_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "measure_translations", ["locale"], :name => "index_measure_translations_on_locale"
  add_index "measure_translations", ["measure_id"], :name => "index_measure_translations_on_measure_id"

  create_table "measures", :force => true do |t|
    t.integer  "measure_category_id"
    t.string   "iso"
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "node_translations", :force => true do |t|
    t.integer  "node_id"
    t.string   "locale"
    t.string   "header"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "node_translations", ["locale"], :name => "index_node_translations_on_locale"
  add_index "node_translations", ["node_id"], :name => "index_node_translations_on_node_id"

  create_table "nodes", :force => true do |t|
    t.integer  "parent"
    t.string   "name"
    t.string   "title"
    t.string   "header"
    t.text     "content"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "accessible_id"
    t.string   "accessible_type"
  end

  add_index "nodes", ["accessible_id", "accessible_type"], :name => "index_nodes_on_accessible_id_and_accessible_type"

  create_table "period_translations", :force => true do |t|
    t.integer  "period_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "period_translations", ["locale"], :name => "index_period_translations_on_locale"
  add_index "period_translations", ["period_id"], :name => "index_period_translations_on_period_id"

  create_table "periods", :force => true do |t|
    t.date     "since"
    t.date     "till"
    t.string   "name"
    t.string   "description"
    t.integer  "order_position"
    t.integer  "hotel_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "image"
    t.string   "description"
    t.integer  "gallery_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "photos", ["gallery_id"], :name => "index_photos_on_gallery_id"

  create_table "post_translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "locale"
    t.string   "title"
    t.text     "teaser"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "post_translations", ["locale"], :name => "index_post_translations_on_locale"
  add_index "post_translations", ["post_id"], :name => "index_post_translations_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "teaser"
    t.text     "content"
    t.integer  "channel_id"
    t.string   "channel_type"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "posts", ["channel_id", "channel_type"], :name => "index_posts_on_channel_id_and_channel_type"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "price_translations", :force => true do |t|
    t.integer  "price_id"
    t.string   "locale"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "price_translations", ["locale"], :name => "index_price_translations_on_locale"
  add_index "price_translations", ["price_id"], :name => "index_price_translations_on_price_id"

  create_table "prices", :force => true do |t|
    t.integer  "room_id"
    t.integer  "period_id"
    t.integer  "value"
    t.integer  "measure_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "region_translations", :force => true do |t|
    t.integer  "region_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "region_translations", ["locale"], :name => "index_region_translations_on_locale"
  add_index "region_translations", ["region_id"], :name => "index_region_translations_on_region_id"

  create_table "regions", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "room_translations", :force => true do |t|
    t.integer  "room_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "room_translations", ["locale"], :name => "index_room_translations_on_locale"
  add_index "room_translations", ["room_id"], :name => "index_room_translations_on_room_id"

  create_table "rooms", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "service_type_id"
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "type_id"
  end

  add_index "rooms", ["type_id"], :name => "index_rooms_on_type_id"

  create_table "service_translations", :force => true do |t|
    t.integer  "service_id"
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "service_translations", ["locale"], :name => "index_service_translations_on_locale"
  add_index "service_translations", ["service_id"], :name => "index_service_translations_on_service_id"

  create_table "services", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "service_type_id"
    t.string   "name"
    t.text     "description"
    t.string   "price"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "type_id"
  end

  add_index "services", ["type_id"], :name => "index_services_on_type_id"

  create_table "tag_categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "filter"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tag_names", :force => true do |t|
    t.integer  "tag_category_id"
    t.string   "ident"
    t.string   "name"
    t.integer  "measure_category_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "tag_options", :force => true do |t|
    t.integer  "tag_name_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "tag_name_id"
    t.integer  "value_int"
    t.integer  "measure_id"
    t.float    "value_flt"
    t.string   "value_str"
    t.integer  "tag_option_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "type_translations", :force => true do |t|
    t.integer  "type_id"
    t.string   "locale"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "type_translations", ["locale"], :name => "index_type_translations_on_locale"
  add_index "type_translations", ["type_id"], :name => "index_type_translations_on_type_id"

  create_table "types", :force => true do |t|
    t.string   "name"
    t.string   "filter"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
    t.string   "slug"
  end

  add_index "types", ["ancestry"], :name => "index_types_on_ancestry"
  add_index "types", ["slug"], :name => "index_types_on_slug"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "roles_mask"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "values", :force => true do |t|
    t.string   "field_id"
    t.string   "measure_id"
    t.string   "value_string"
    t.integer  "value_integer"
    t.float    "value_float"
    t.datetime "value_datetime"
    t.time     "value_time"
    t.integer  "evaluated_id"
    t.string   "evaluated_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "values", ["evaluated_id", "evaluated_type"], :name => "index_values_on_evaluated_id_and_evaluated_type"

end
