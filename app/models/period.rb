class Period < ActiveRecord::Base
  belongs_to :hotel
  has_many :rooms, through: :prices
  attr_accessible :description, :name, :order_position, :since, :till, :hotel_id
  translates :name

  def title
    "#{self.name} (#{self.since.to_formatted_s :short} - #{self.till.to_formatted_s :short})"
  end

end
