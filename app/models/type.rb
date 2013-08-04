class Type < ActiveRecord::Base
  belongs_to :measure_category
  has_many :fields
  has_many :hotels
  has_many :rooms
  has_many :services
  attr_accessible :filter, :name, :fields_attributes, :parent_id
  accepts_nested_attributes_for :fields, allow_destroy: true

  has_ancestry


  def collection_for_parent_select
    ancestry_options(self.subtree.unscoped.arrange(:order => 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
  end

  def ancestry_options(items)
    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      #this is a recursive call:
      result += ancestry_options(sub_items) {|i| "#{'-' * i.depth} #{i.name}" }
    end
    result
  end

end
