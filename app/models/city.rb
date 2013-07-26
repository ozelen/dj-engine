class City < ActiveRecord::Base
  belongs_to :region
  has_many :hotels
  attr_accessible :description, :location, :name, :region_id
  translates :name, :description
  has_one :node, as: :accessible, :dependent => :destroy

  def to_param
    self.node.name
  end

end
