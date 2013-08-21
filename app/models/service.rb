class Service < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :type
  has_many :tags, as: :taggable
  has_many :values, as: :evaluated

  accepts_nested_attributes_for :values, allow_destroy: true

  attr_accessible :description, :hotel_id, :name, :price, :type_id, :values_attributes


  translates :name, :description, :price

end
