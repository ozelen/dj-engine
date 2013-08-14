class Hotel < ActiveRecord::Base
  has_one :node, as: :accessible, :dependent => :destroy
  belongs_to :city
  belongs_to :user
  belongs_to :type
  has_many :values, as: :evaluated
  has_many :rooms
  has_many :services
  has_many :periods
  has_many :tags, as: :taggable
  has_many :assignments, as: :assigned

  has_many :values, as: :evaluated
  has_many :galleries, as: :imageable
  has_many :fields, through: :values

  has_many :prices, through: :periods

  accepts_nested_attributes_for :node, allow_destroy: true
  accepts_nested_attributes_for :values, allow_destroy: true
  accepts_nested_attributes_for :rooms, allow_destroy: true
  accepts_nested_attributes_for :services, allow_destroy: true
  accepts_nested_attributes_for :periods, allow_destroy: true
  accepts_nested_attributes_for :periods, :prices, allow_destroy: true

  attr_accessible :city_id, :description, :location, :name, :user_id, :ident, :type_id, :fields,
                  :values_attributes, :node_attributes,
                  :rooms_attributes, :services_attributes,
                  :periods_attributes, :prices_attributes

  translates :name, :description

  validate :validate_properties

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

end
