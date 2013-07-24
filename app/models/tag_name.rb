class TagName < ActiveRecord::Base
  has_many :tags
  has_many :tag_options
  attr_accessible :ident, :measure_category_id, :name, :tag_category_id
end
