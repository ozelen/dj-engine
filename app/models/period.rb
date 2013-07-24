class Period < ActiveRecord::Base
  belongs_to :hotel
  has_many :rooms, through: :room_prices
  attr_accessible :description, :name, :order_position, :since, :till
end
