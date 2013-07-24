class HotelService < ActiveRecord::Base
  attr_accessible :description, :hotel_id, :name, :price, :service_type_id
end
