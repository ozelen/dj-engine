class MeasureCategory < ActiveRecord::Base
  attr_accessible :data_type, :filter, :name
  translates :name
end