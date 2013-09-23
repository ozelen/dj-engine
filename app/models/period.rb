class Period < ActiveRecord::Base
  belongs_to :hotel
  has_many :prices
  has_many :rooms, through: :prices

  accepts_nested_attributes_for :prices
  attr_accessible :description, :name, :order_position, :since, :till, :hotel_id, :prices_attributes

  translates :name

  def title
    dates = "#{self.since.to_formatted_s :short} - #{self.till.to_formatted_s :short}"
    name.present? ? "#{name} (#{dates})" : dates
  end


end
