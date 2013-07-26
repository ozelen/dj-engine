class Room < ActiveRecord::Base
  belongs_to :hotel
  has_many :prices
  has_many :periods, through: :prices
  has_many :tags, as: :taggable
  has_one :node, as: :accessible, :dependent => :destroy
  attr_accessible :description, :hotel_id, :name, :price, :service_type_id
  translates :name, :description

  def to_param
    self.node.name
  end

end
