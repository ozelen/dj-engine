class City < ActiveRecord::Base
  attr_accessible :description, :location, :name, :region_id
end
