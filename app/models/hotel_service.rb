class HotelService < ActiveRecord::Base
  belongs_to :hotel
  attr_accessible :description, :hotel_id, :name, :price, :service_type_id
end
