class Type < ActiveRecord::Base
  belongs_to :measure_category
  has_many :fields
  attr_accessible :filter, :name, :fields_attributes
  accepts_nested_attributes_for :fields, allow_destroy: true
end
