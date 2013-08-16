class FieldCategory < ActiveRecord::Base
  belongs_to :type
  has_many :fields, dependent: :destroy
  translates :name
  accepts_nested_attributes_for :fields, allow_destroy: true
  attr_accessible :name, :slug, :fields_attributes
end
