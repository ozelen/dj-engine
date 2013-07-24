class Hotel < ActiveRecord::Base
  attr_accessible :city_id, :description, :location, :name
end
