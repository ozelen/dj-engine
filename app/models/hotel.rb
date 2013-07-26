class Hotel < ActiveRecord::Base
  has_one :node, as: :accessible, :dependent => :destroy
  belongs_to :city
  belongs_to :user
  has_many :rooms
  has_many :services
  has_many :periods
  has_many :tags, as: :taggable
  has_many :assignments, as: :assigned

  accepts_nested_attributes_for :node
  attr_accessible :city_id, :description, :location, :name, :user_id, :ident, :node_attributes

  translates :name, :description

  def to_param
    self.node.name
  end

  def node_name
    self.node.name
  end

end
