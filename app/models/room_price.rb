class RoomPrice < ActiveRecord::Base
  attr_accessible :description, :measure_id, :period_id, :room_id, :value
end
