class Resort < ActiveRecord::Base
  # virtual model for resort's behaviour
  belongs_to :type
  has_one :location, as: :located
  has_one :node, as: :accessible, dependent: :destroy
  has_many :posts, as: :channel
  has_one :gallery, as: :imageable
  has_many :photos, through: :gallery

  has_many :resort_tour_assignments
  has_many :tours, through: :resort_tour_assignments

  accepts_nested_attributes_for :node, allow_destroy: true
  accepts_nested_attributes_for :gallery, :photos, allow_destroy: true
  accepts_nested_attributes_for :location, allow_destroy: true
  attr_accessible :gallery_attributes, :node_attributes, :location_attributes
  acts_as_commentable

  after_create :create_gallery
  acts_as_taggable_on :portals

  def to_param
    self.node.name
  end

  def name
    node.header
  end

end
