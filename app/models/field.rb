class Field < ActiveRecord::Base
  belongs_to :measure_category
  belongs_to :type
  has_many :values

  has_many :evaluated, through: :values

  attr_accessible :name, :required, :measure_category_id
end