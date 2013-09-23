class Room < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :type
  has_many :prices, dependent: :destroy
  has_many :periods, through: :prices
  has_many :tags, as: :taggable
  has_one :gallery, as: :imageable, dependent: :destroy
  has_many :photos, through: :gallery

  has_many :values, as: :evaluated, dependent: :destroy
  has_many :fields, through: :values
  has_many :field_categories, through: :fields

  accepts_nested_attributes_for :gallery
  accepts_nested_attributes_for :values, allow_destroy: true

  attr_accessible :description, :hotel_id, :name, :price, :type_id, :gallery_attributes, :values_attributes
  translates :name, :description

  after_create :create_gallery

  acts_as_commentable

  def caption
    if name.present? and type.present? and type.parent.present?
      "#{name} (#{type.name})"
    elsif name.present?
      name
    elsif type.present?
      type.name
    end
  end

  def price_per_period preiod
    prices.last.value if preiod.present? and prices.last
  end

end
