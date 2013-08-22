class Location < ActiveRecord::Base
  belongs_to :located, polymorphic: true
  attr_accessible :address, :latitude, :located_id, :located_type, :longitude
  geocoded_by :address
  #after_validation :geocode, :if => :address_changed?
end
