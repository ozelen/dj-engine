class Value < ActiveRecord::Base
  belongs_to :evaluated, polymorphic: true
  belongs_to :field
  belongs_to :measure
  attr_accessible :evaluated_id, :evaluated_type, :field_id, :measure_id, :value_datetime, :value_float, :value_integer, :value_string, :value_time
end