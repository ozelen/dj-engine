class City < ActiveRecord::Base
  belongs_to :region
  has_many :hotels
  attr_accessible :description, :location, :name, :region_id
  translates :name, :description
end
