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

ActiveRecord::Schema.define(:version => 20160726223922) do

  create_table "address_translations", :force => true do |t|
    t.integer  "address_id"
    t.string   "locale"
    t.text     "addr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "address_translations", ["address_id"], :name => "index_address_translations_on_address_id"
  add_index "address_translations", ["locale"], :name => "index_address_translations_on_locale"

  create_table "addresses", :force => true do |t|
    t.string   "email"
    t.string   "website"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "fax"
    t.string   "skype"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "addr"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], :name => "index_addresses_on_addressable_id_and_addressable_type"
  add_index "addresses", ["email"], :name => "index_addresses_on_email"

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

  add_index "authentications", ["provider", "uid"], :name => "index_authentications_on_provider_and_uid"
  add_index "authentications", ["provider"], :name => "index_authentications_on_provider"
  add_index "authentications", ["uid"], :name => "index_authentications_on_uid"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "cities", :force => true do |t|
    t.float    "location"
    t.integer  "region_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.string   "username"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "deals", :force => true do |t|
    t.integer  "dealable_id"
    t.string   "dealable_type"
    t.string   "person_name"
    t.string   "login"
    t.string   "password"
    t.integer  "price"
    t.date     "begin_date"
    t.date     "expire_date"
    t.text     "contacts"
    t.integer  "status"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "deals", ["begin_date"], :name => "index_deals_on_begin_date"
  add_index "deals", ["dealable_id", "dealable_type"], :name => "index_deals_on_dealable_id_and_dealable_type"
  add_index "deals", ["expire_date"], :name => "index_deals_on_expire_date"
  add_index "deals", ["person_name"], :name => "index_deals_on_person_name"
  add_index "deals", ["price"], :name => "index_deals_on_price"
  add_index "deals", ["status"], :name => "index_deals_on_status"

  create_table "field_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "type_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "field_categories", ["slug"], :name => "index_field_categories_on_slug"
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

  create_table "hotel_tour_assignments", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "tour_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "hotel_tour_assignments", ["hotel_id"], :name => "index_hotel_tour_assignments_on_hotel_id"
  add_index "hotel_tour_assignments", ["tour_id"], :name => "index_hotel_tour_assignments_on_tour_id"

  create_table "hotels", :force => true do |t|
    t.float    "location"
    t.integer  "city_id"
    t.integer  "user_id"
    t.string   "ident"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "type_id"
    t.integer  "donated"
    t.date     "deal_expire"
    t.string   "facebook_page_url"
  end

  add_index "hotels", ["city_id"], :name => "index_hotels_on_city_id"
  add_index "hotels", ["deal_expire"], :name => "index_hotels_on_deal_expire"
  add_index "hotels", ["donated"], :name => "index_hotels_on_donated"
  add_index "hotels", ["type_id"], :name => "index_hotels_on_type_id"
  add_index "hotels", ["user_id"], :name => "index_hotels_on_user_id"

  create_table "leads", :force => true do |t|
    t.string   "provider"
    t.integer  "leader_id"
    t.string   "leader_type"
    t.string   "params"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "leads", ["leader_id", "leader_type"], :name => "index_leads_on_leader_id_and_leader_type"
  add_index "leads", ["params"], :name => "index_leads_on_params"
  add_index "leads", ["provider"], :name => "index_leads_on_provider"

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "located_id"
    t.string   "located_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "locations", ["address"], :name => "index_locations_on_address"
  add_index "locations", ["latitude"], :name => "index_locations_on_latitude"
  add_index "locations", ["located_id", "located_type"], :name => "index_locations_on_located_id_and_located_type"
  add_index "locations", ["longitude"], :name => "index_locations_on_longitude"

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

  add_index "measures", ["measure_category_id"], :name => "index_measures_on_measure_category_id"

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
    t.string   "parent"
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
  add_index "nodes", ["header"], :name => "index_nodes_on_header"
  add_index "nodes", ["name"], :name => "index_nodes_on_name"
  add_index "nodes", ["parent"], :name => "index_nodes_on_parent"

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

  add_index "periods", ["hotel_id"], :name => "index_periods_on_hotel_id"

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
  add_index "posts", ["slug"], :name => "index_posts_on_slug"
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

  add_index "prices", ["measure_id"], :name => "index_prices_on_measure_id"
  add_index "prices", ["period_id"], :name => "index_prices_on_period_id"
  add_index "prices", ["room_id"], :name => "index_prices_on_room_id"
  add_index "prices", ["value"], :name => "index_prices_on_value"

  create_table "redirects", :force => true do |t|
    t.string   "old_domain"
    t.string   "old_path"
    t.string   "new_path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "redirects", ["new_path"], :name => "index_redirects_on_new_path"
  add_index "redirects", ["old_domain"], :name => "index_redirects_on_old_domain"
  add_index "redirects", ["old_path"], :name => "index_redirects_on_old_path"

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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resort_city_assignments", :force => true do |t|
    t.integer  "resort_id"
    t.integer  "city_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "resort_city_assignments", ["city_id"], :name => "index_resort_city_assignments_on_city_id"
  add_index "resort_city_assignments", ["resort_id"], :name => "index_resort_city_assignments_on_resort_id"

  create_table "resort_tour_assignments", :force => true do |t|
    t.integer  "resort_id"
    t.integer  "tour_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "resort_tour_assignments", ["resort_id"], :name => "index_resort_tour_assignments_on_resort_id"
  add_index "resort_tour_assignments", ["tour_id"], :name => "index_resort_tour_assignments_on_tour_id"

  create_table "resorts", :force => true do |t|
    t.integer  "type_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "resorts", ["type_id"], :name => "index_resorts_on_type_id"

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

  add_index "rooms", ["hotel_id"], :name => "index_rooms_on_hotel_id"
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

  add_index "services", ["hotel_id"], :name => "index_services_on_hotel_id"
  add_index "services", ["type_id"], :name => "index_services_on_type_id"

  create_table "skiworld_legacies", :force => true do |t|
    t.integer  "legatee_id"
    t.string   "legatee_type"
    t.integer  "legator_id"
    t.string   "legator_table"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "skiworld_legacies", ["legatee_id", "legatee_type"], :name => "index_skiworld_legacies_on_legatee_id_and_legatee_type"
  add_index "skiworld_legacies", ["legator_id"], :name => "index_skiworld_legacies_on_legator_id"
  add_index "skiworld_legacies", ["legator_table"], :name => "index_skiworld_legacies_on_legator_table"

  create_table "streams", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tour_translations", :force => true do |t|
    t.integer  "tour_id"
    t.string   "locale"
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tour_translations", ["locale"], :name => "index_tour_translations_on_locale"
  add_index "tour_translations", ["tour_id"], :name => "index_tour_translations_on_tour_id"

  create_table "tours", :force => true do |t|
    t.string   "slug"
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
  end

  add_index "tours", ["name"], :name => "index_tours_on_name"
  add_index "tours", ["slug"], :name => "index_tours_on_slug"
  add_index "tours", ["user_id"], :name => "index_tours_on_user_id"

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
    t.integer  "field_id"
    t.integer  "measure_id"
    t.string   "value_string"
    t.integer  "value_integer"
    t.float    "value_float"
    t.datetime "value_datetime"
    t.time     "value_time"
    t.integer  "evaluated_id"
    t.string   "evaluated_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "value_boolean"
  end

  add_index "values", ["evaluated_id", "evaluated_type"], :name => "index_values_on_evaluated_id_and_evaluated_type"
  add_index "values", ["field_id"], :name => "index_values_on_field_id"
  add_index "values", ["measure_id"], :name => "index_values_on_measure_id"

end
