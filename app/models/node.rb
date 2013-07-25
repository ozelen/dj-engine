class Node < ActiveRecord::Base
  attr_accessible :content, :header, :name, :parent, :title
  translates :header, :content, :title
end
