class ResortTourAssignment < ActiveRecord::Base
  belongs_to :resort
  belongs_to :tour
  attr_accessible :resort_id, :tour_id
end
