class Region < ActiveRecord::Base
  has_many :cities
  has_many :hotels, through: :cities
  attr_accessible :description, :name, :parent_id
  translates :name, :description
  has_one :node, as: :accessible, :dependent => :destroy

  def to_param
    self.node.name
  end

end
