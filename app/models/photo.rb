class Photo < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :description, :image, :gallery_id, :remote_image_url
  mount_uploader :image, ImageUploader
end
