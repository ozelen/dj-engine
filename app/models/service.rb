class Service < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :type
  has_many :tags, as: :taggable
  attr_accessible :description, :hotel_id, :name, :price, :type_id
  translates :name, :description, :price

end
