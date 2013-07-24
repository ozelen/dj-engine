class RoomPrice < ActiveRecord::Base
  belongs_to :room
  belongs_to :period
  attr_accessible :description, :measure_id, :period_id, :room_id, :value
end
