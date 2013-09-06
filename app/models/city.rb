class City < ActiveRecord::Base
  belongs_to :region
  has_many :hotels
  has_one :location, as: :located, dependent: :destroy
  has_one :node, as: :accessible, :dependent => :destroy

  accepts_nested_attributes_for  :node, :location
  attr_accessible :region_id, :node_attributes, :location_attributes

  def to_param
    self.node.name
  end

  def city_name
    node.header
  end

  def name
    node.header
  end

  def name=(name)
    node.header=name
  end

  def description
    node.content
  end

  def description=(text)
    node.content=text
  end

end
