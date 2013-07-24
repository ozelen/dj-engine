class TagCategory < ActiveRecord::Base
  attr_accessible :filter, :name, :parent_id
end
