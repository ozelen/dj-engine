class Hotel < ActiveRecord::Base
  belongs_to :city
  belongs_to :user
  has_many :rooms
  has_many :services
  has_many :periods
  has_many :tags, as: :taggable
  attr_accessible :city_id, :description, :location, :name, :user_id, :ident
  translates :name, :description
end
