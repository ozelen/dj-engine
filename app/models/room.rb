class Room < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :type
  has_many :prices
  has_many :periods, through: :prices
  has_many :tags, as: :taggable
  has_one :gallery, as: :imageable

  accepts_nested_attributes_for :gallery
  attr_accessible :description, :hotel_id, :name, :price, :type_id, :gallery_attributes
  translates :name, :description

  after_create :create_gallery

  def create_gallery
    unless self.gallery
      self.gallery = Gallery.create
      self.save!
    end
  end

end
