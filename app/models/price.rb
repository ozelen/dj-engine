class Price < ActiveRecord::Base
  belongs_to :room
  belongs_to :period
  belongs_to :hotel
  attr_accessible :description, :measure_id, :period_id, :room_id, :value
  translates :description
end
