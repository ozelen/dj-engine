class Hotel < ActiveRecord::Base
  belongs_to :city
  belongs_to :user
  has_many :rooms
  has_many :hotel_services
  has_many :periods
  attr_accessible :city_id, :description, :location, :name
end
