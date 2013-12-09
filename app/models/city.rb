class City < ActiveRecord::Base
  extend Poi

  belongs_to :region
  has_many :hotels
  has_one :location, as: :located,  dependent: :destroy
  has_one :node, as: :accessible,   dependent: :destroy

  has_one :gallery, as: :imageable, dependent: :destroy
  has_many :photos, through: :gallery

  has_many :resort_city_assignments, dependent: :destroy
  has_many :resorts, through: :resort_city_assignments

  has_one :lead, as: :leader, dependent: :destroy
  has_one :skiworld_legacy, as: :legatee, dependent: :destroy

  after_create :create_gallery
  acts_as_taggable_on :portals

  accepts_nested_attributes_for  :node, :location, allow_destroy: true
  accepts_nested_attributes_for :skiworld_legacy, allow_destroy: true
  accepts_nested_attributes_for :lead, allow_destroy: true

  attr_accessible :region_id, :node_attributes, :location_attributes,
                  :lead_attributes, :skiworld_legacy_attributes

  default_scope includes({node: :translations}).order("node_translations.header ASC")
  #default_scope order: :updated_at

  def comments
    Comment.where(commentable_type: 'Hotel', commentable_id: self.id)
  end

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

  def self.find_by_slug slug
    Node.find_by_name(slug).accessible
  end

end
