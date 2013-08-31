class Gallery < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_many :photos
  accepts_nested_attributes_for :photos
  attr_accessible :cover_photo_id, :description, :imageable_id, :imageable_type, :name, :photos_attributes


  def title
    rand(:title) || photos.first rescue 'no photo'
  end

  def rand(mode)
    arr = self.photos.tagged_with(mode)
    a = arr.blank? ? gallery.photos.first : arr.sample rescue nil
  end

  def tagged(mode)
    self.photos.tagged_with(mode)
  end

end
