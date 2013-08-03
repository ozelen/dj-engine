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

  has_many :fields

  accepts_nested_attributes_for :node
  attr_accessible :city_id, :description, :location, :name, :user_id, :ident, :node_attributes, :type_id

  translates :name, :description

  def to_param
    self.node.name
  end

  def node_name
    self.node.name
  end

end
