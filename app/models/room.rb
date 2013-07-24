class Room < ActiveRecord::Base
  belongs_to :hotel
  has_many :periods, through: :room_prices
  attr_accessible :description, :hotel_id, :name, :price, :service_type_id
end
