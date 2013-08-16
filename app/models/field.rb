class Field < ActiveRecord::Base
  belongs_to :measure_category
  belongs_to :field_category
  has_many :values
  translates :name

  has_many :evaluated, through: :values

  attr_accessible :name, :required, :measure_category_id, :slug
end
