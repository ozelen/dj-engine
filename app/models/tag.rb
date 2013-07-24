class Tag < ActiveRecord::Base
  belongs_to :tag_category
  belongs_to :tag_name
  belongs_to :tag_option
  belongs_to :taggable, polymorphic: true
  attr_accessible :tag_name_id, :value_flt, :value_int, :value_str, :tag_option_id
end
