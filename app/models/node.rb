class Node < ActiveRecord::Base
  belongs_to :accessible, polymorphic: true
  attr_accessible :content, :header, :name, :parent, :title, :accessible_id, :accessible_type
  translates :header, :content, :title
end
