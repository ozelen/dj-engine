class Room < ActiveRecord::Base
  attr_accessible :descripion, :hotel_id, :name, :price, :service_type_id
end
