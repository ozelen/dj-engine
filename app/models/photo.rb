class Photo < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :description, :image
end
