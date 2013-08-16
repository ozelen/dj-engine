class Gallery < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_many :photos
  accepts_nested_attributes_for :photos
  attr_accessible :cover_photo_id, :description, :imageable_id, :imageable_type, :name, :photos_attributes
end
