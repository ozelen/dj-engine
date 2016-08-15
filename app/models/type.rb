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

  def to_s
    name
  end

  def collection_for_parent_select slug=nil
    if slug
      root = Type.find_by_slug(slug)
      subtree = root.subtree
    else
      subtree = self.subtree.unscoped
    end

    ancestry_options(subtree.arrange(:order => 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
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

  def upgoing_field_categories
    # TODO: provide full list of upgoing and own field categories
    root.field_categories
  end

end
