class HotelTourAssignment < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :tour
  attr_accessible :hotel_id, :tour_id
end
