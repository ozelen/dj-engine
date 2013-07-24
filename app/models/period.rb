class Period < ActiveRecord::Base
  attr_accessible :description, :name, :order_position, :since, :till
end
