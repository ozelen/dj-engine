class Stream < ActiveRecord::Base
  # virtual model for portal thematic behaviour
  has_one :node, as: :accessible, dependent: :destroy
  has_many :posts, as: :channel
  has_many :galleries, as: :imageable, dependent: :destroy
  has_many :photos, through: :gallery
  accepts_nested_attributes_for :node, allow_destroy: true
  attr_accessible :node_attributes

  def to_param
    self.node.name
  end

  def self.find_by_slug slug
    Node.find_by_name(slug).accessible
  end

end
