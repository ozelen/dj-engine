class Hotel < ActiveRecord::Base
  has_one :node, as: :accessible, dependent: :destroy#, after_add: :create_node #, before_destroy: :destroy_node
  belongs_to :city
  belongs_to :user
  belongs_to :type
  has_many :values, as: :evaluated
  has_many :rooms
  has_many :services
  has_many :tags, as: :taggable
  has_many :assignments, as: :assigned

  has_many :values, as: :evaluated
  has_many :fields, through: :values
  has_many :field_categories, through: :fields

  has_many :periods
  has_many :prices, through: :periods

  has_one :gallery, as: :imageable
  has_many :photos, through: :gallery
  has_many :posts, as: :channel

  accepts_nested_attributes_for :node, allow_destroy: true
  accepts_nested_attributes_for :values, allow_destroy: true
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :services, allow_destroy: true
  accepts_nested_attributes_for :periods, allow_destroy: true
  accepts_nested_attributes_for :periods, :prices, allow_destroy: true
  accepts_nested_attributes_for :gallery, :photos, allow_destroy: true


  attr_accessible :city_id, :location, :user_id, :ident, :type_id, :fields,
                  :values_attributes, :node_attributes,
                  :rooms_attributes, :services_attributes,
                  :periods_attributes, :prices_attributes,
                  :gallery_attributes, :photos_attributes

  translates :name, :description

  validate :validate_properties

  acts_as_commentable

  after_create :create_gallery

  def to_param
    self.node.name
  end

  def node_name
    self.node.name
  end

  def validate_properties
    values.each do |value|
      if value.field.required? && value.value_string == ''
        errors.add value.field.name, "must not be blank"
      end
    end
  end

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

end
