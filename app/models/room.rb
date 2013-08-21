class Room < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :type
  has_many :prices
  has_many :periods, through: :prices
  has_many :tags, as: :taggable
  has_one :gallery, as: :imageable
  has_many :values, as: :evaluated

  accepts_nested_attributes_for :gallery
  accepts_nested_attributes_for :values, allow_destroy: true

  attr_accessible :description, :hotel_id, :name, :price, :type_id, :gallery_attributes, :values_attributes
  translates :name, :description

  after_create :create_gallery

end
