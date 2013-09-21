class ResortCityAssignment < ActiveRecord::Base
  belongs_to :resort
  belongs_to :city
  attr_accessible :resort_id, :city_id
  # attr_accessible :title, :body
end
