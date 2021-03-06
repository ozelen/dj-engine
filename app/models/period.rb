class Period < ActiveRecord::Base
  belongs_to :hotel
  has_many :prices
  has_many :rooms, through: :prices

  accepts_nested_attributes_for :prices
  attr_accessible :description, :name, :order_position, :since, :till, :hotel_id, :prices_attributes

  translates :name

  default_scope order('till DESC')

  def title
    dates = "#{I18n.l(self.since, format: :short)} - #{I18n.l(self.till, format: :short)}" if since && till
    name.present? ? "#{name} (#{dates})" : dates
  end


end
