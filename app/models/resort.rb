class Resort < ActiveRecord::Base

  # virtual model for resort's behaviour
  belongs_to :type
  has_one :location, as: :located, dependent: :destroy
  has_one :node, as: :accessible,   dependent: :destroy
  has_many :posts, as: :channel
  has_one :gallery, as: :imageable, dependent: :destroy
  has_many :photos, through: :gallery

  has_many :resort_tour_assignments, dependent: :destroy
  has_many :tours, through: :resort_tour_assignments

  has_many :resort_city_assignments, dependent: :destroy
  has_many :cities, through: :resort_city_assignments

  has_many :hotels, through: :cities

  accepts_nested_attributes_for :node, allow_destroy: true
  accepts_nested_attributes_for :gallery, :photos, allow_destroy: true
  accepts_nested_attributes_for :location, allow_destroy: true
  accepts_nested_attributes_for :resort_city_assignments, allow_destroy: true

  attr_accessible :gallery_attributes, :node_attributes, :location_attributes, :resort_city_assignments_attributes, :portal_list

  acts_as_commentable
  acts_as_taggable_on :portals

  after_create :create_gallery


  def to_param
    self.node.name
  end

  def name
    node.header
  end

  def description
    node.content
  end

  def slug
    node.name
  end

  def slug=(slug)
    node.name=slug
  end

end
