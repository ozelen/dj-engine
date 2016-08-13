class Hotel < ActiveRecord::Base
  # extend Poi

  has_one :node, as: :accessible, dependent: :destroy#, after_add: :create_node #, before_destroy: :destroy_node
  belongs_to :city
  belongs_to :user
  belongs_to :type
  has_many :rooms,      dependent: :destroy
  has_many :services,   dependent: :destroy

  has_many :values, as: :evaluated, dependent: :destroy
  has_many :fields, through: :values
  has_many :field_categories, through: :fields

  has_many :periods, dependent: :destroy, dependent: :destroy
  has_many :prices, through: :periods

  has_one :gallery, as: :imageable, dependent: :destroy
  has_many :photos, through: :gallery
  has_many :posts, as: :channel, dependent: :destroy

  has_many :hotel_tour_assignments, dependent: :destroy
  has_many :tours, through: :hotel_tour_assignments

  has_one :location, as: :located, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  has_many :deals, as: :dealable, dependent: :destroy
  has_many :leads, as: :leader, dependent: :destroy
  has_one :skiworld_legacy, as: :legatee, dependent: :destroy

  accepts_nested_attributes_for :node, allow_destroy: true
  accepts_nested_attributes_for :values, allow_destroy: true
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :services, allow_destroy: true
  accepts_nested_attributes_for :periods, allow_destroy: true
  accepts_nested_attributes_for :periods, :prices, allow_destroy: true
  accepts_nested_attributes_for :gallery, :photos, allow_destroy: true
  accepts_nested_attributes_for :location, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :deals, allow_destroy: true
  accepts_nested_attributes_for :skiworld_legacy, allow_destroy: true
  accepts_nested_attributes_for :leads, allow_destroy: true

  attr_accessible :city_id, :location, :user_id, :ident, :type_id, :fields,
                  :values_attributes, :node_attributes,
                  :fields_attributes,
                  :rooms_attributes, :services_attributes,
                  :periods_attributes, :prices_attributes,
                  :gallery_attributes, :photos_attributes,
                  :location_attributes, :address_attributes,
                  :deals_attributes, :leads_attributes,
                  :skiworld_legacy_attributes,
                  :portal_list, :facebook_page_url

  # validate :validate_properties

  acts_as_commentable
  acts_as_taggable_on :portals

  after_create :create_gallery

  # acts_as_poi

  scope :by_resort, lambda { includes(node: :translations) }
  default_scope order("deal_expire DESC")

  def to_param
    self.node.name
  end

  def node_name
    self.node.name
  end

  # def validate_properties
  #   values.each do |value|
  #     if value.field and value.field.required? && value.value_string == ''
  #       errors.add value.field.name, "must not be blank"
  #     end
  #   end
  # end

  def delete_node
    node.destroy if node
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

  def slug
    node.name
  end

  def slug=(slug)
    node.name=slug
  end

  def get_photos_from_collection *col
    arr = []
    col.each { |c| c.map{ |x| arr.concat(x.photos) } }
    arr
  end

  def all_photos limit=nil
    photos.dup.concat(get_photos_from_collection(rooms, services))
  end

  def current_period
    periods.last # TODO: select current period
  end

end
