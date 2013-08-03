class Type < ActiveRecord::Base
  belongs_to :measure_category
  has_many :fields
  has_many :hotels
  has_many :rooms
  has_many :services
  attr_accessible :filter, :name, :fields_attributes
  accepts_nested_attributes_for :fields, allow_destroy: true
end
