class Region < ActiveRecord::Base
  has_many :cities
  has_many :hotels, through: :cities
  attr_accessible :description, :name, :parent_id
end
