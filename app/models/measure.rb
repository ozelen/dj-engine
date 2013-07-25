class Measure < ActiveRecord::Base
  attr_accessible :iso, :measure_category_id, :name
  translates :name
end
