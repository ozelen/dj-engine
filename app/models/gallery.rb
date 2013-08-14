class Gallery < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  attr_accessible :cover_photo_id, :description, :imageable_id, :imageable_type, :name
end
