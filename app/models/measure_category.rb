class MeasureCategory < ActiveRecord::Base
  has_many :measures
  accepts_nested_attributes_for :measures, allow_destroy: true
  attr_accessible :data_type, :filter, :name, :measures_attributes

  translates :name

  def data_types
    %w[integer float string datetime]
  end

end
