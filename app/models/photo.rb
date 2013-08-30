class Photo < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :description, :image, :gallery_id, :remote_image_url, :mode_list
  mount_uploader :image, ImageUploader

  acts_as_taggable_on :modes, :tags
end
