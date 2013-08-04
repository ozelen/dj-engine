class Measure < ActiveRecord::Base
  belongs_to :category, class_name: "MeasureCategory"
  has_many :values
  attr_accessible :iso, :measure_category_id, :name
  translates :name
end
