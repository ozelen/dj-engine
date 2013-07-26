class Service < ActiveRecord::Base
  belongs_to :hotel
  has_many :tags, as: :taggable
  attr_accessible :description, :hotel_id, :name, :price, :service_type_id
  translates :name, :description, :price

end
