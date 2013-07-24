class TagOption < ActiveRecord::Base
  belongs_to :tag_name
  has_many :tags
  attr_accessible :name, :tag_name_id
end
