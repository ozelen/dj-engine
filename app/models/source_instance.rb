class SourceInstance < ActiveRecord::Base
  has_one :source_class
  has_many :children, class_name: 'SourceInstance', foreign_key: 'parent_instance_id'
  belongs_to :parent, class_name: 'SourceInstance'
  attr_accessible :description, :name, :source_class_id, :parent_instance_id
end
