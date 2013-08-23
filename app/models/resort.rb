class Resort < ActiveRecord::Base
  # virtual model for resort's behaviour
  belongs_to :type
  has_one :location, as: :located
  has_one :node, as: :accessible, dependent: :destroy
  has_many :posts, as: :channel
  has_many :galleries, as: :imageable
  has_many :photos, through: :gallery
  accepts_nested_attributes_for :node, allow_destroy: true
  accepts_nested_attributes_for :galleries, :photos, allow_destroy: true
  accepts_nested_attributes_for :location, allow_destroy: true
  attr_accessible :galleries_attributes, :node_attributes, :location_attributes
  acts_as_commentable

  def to_param
    self.node.name
  end
end
