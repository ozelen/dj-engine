class Hotel < ActiveRecord::Base
  has_one :node, as: :accessible
  belongs_to :city
  belongs_to :user
  has_many :rooms
  has_many :services
  has_many :periods
  has_many :tags, as: :taggable
  has_many :assignments, as: :assigned
  attr_accessible :city_id, :description, :location, :name, :user_id, :ident
  translates :name, :description

  def to_param
    ident
  end

  def node_name
    self.node.name
  end

end
