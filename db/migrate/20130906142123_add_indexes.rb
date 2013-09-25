class AddIndexes < ActiveRecord::Migration
  def up
    add_index :rooms, :hotel_id
    add_index :services, :hotel_id
    add_index :periods, :hotel_id
    add_index :prices, :room_id
    add_index :prices, :period_id
    add_index :prices, :measure_id
    add_index :prices, :value
    add_index :measures, :measure_category_id
    add_index :values, :field_id
    add_index :values, :measure_id
    add_index :authentications, :user_id
    add_index :authentications, :provider
    add_index :authentications, :uid
    add_index :authentications, [:provider, :uid]
    add_index :field_categories, :slug
    add_index :posts, :slug
    add_index :locations, :address
    add_index :locations, :latitude
    add_index :locations, :longitude
    add_index :resorts, :type_id
    add_index :tours, :slug
    add_index :tours, :name
    add_index :addresses, :email
  end

  def down

  end
end
