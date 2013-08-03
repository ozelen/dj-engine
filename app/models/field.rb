class Field < ActiveRecord::Base
  belongs_to :measure_category
  belongs_to :type
  attr_accessible :name, :required, :measure_category_id
end
