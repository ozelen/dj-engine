class Value < ActiveRecord::Base
  belongs_to :evaluated, polymorphic: true
  belongs_to :field
  belongs_to :measure

  def type_name
    field.measure_category.type_name if field.measure_category
  end

  def value_field_name
    "value_#{type_name}"
  end

  def value
    self[value_field_name]
  end

  def unit
    field.measure
  end

  def full_value
    "#{value} #{measure && measure.name}"
  end

  def to_s
    value ?
      "#{field.name}: #{full_value}" :
      field.name
  end

  attr_accessible :evaluated_id, :evaluated_type, :field_id, :measure_id, :value_datetime, :value_float, :value_integer, :value_string, :value_time, :value_boolean
end
