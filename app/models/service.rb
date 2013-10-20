class Service < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :type

  has_many :values, as: :evaluated, dependent: :destroy
  has_many :fields, through: :values
  has_many :field_categories, through: :fields
  has_one :gallery, as: :imageable, dependent: :destroy
  has_many :photos, through: :gallery
  has_one :skiworld_legacy, as: :legatee, dependent: :destroy

  accepts_nested_attributes_for :values, allow_destroy: true
  accepts_nested_attributes_for :skiworld_legacy, allow_destroy: true

  acts_as_category

  attr_accessible :description, :hotel_id, :name, :price, :type_id, :values_attributes, :skiworld_legacy_attributes

  after_create :create_gallery

  translates :name, :description, :price

end
