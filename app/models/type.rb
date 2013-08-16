class Type < ActiveRecord::Base
  belongs_to :measure_category
  has_many :field_categories, dependent: :destroy
  has_many :fields, through: :field_categories, dependent: :destroy
  has_many :hotels
  has_many :rooms
  has_many :services
  #accepts_nested_attributes_for :fields, allow_destroy: true
  accepts_nested_attributes_for :field_categories, allow_destroy: true
  attr_accessible :filter, :name, :field_categories_attributes, :parent_id, :slug

  has_ancestry
  translates :name


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
