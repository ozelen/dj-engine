class SkiworldLegacy < ActiveRecord::Base
  belongs_to :legatee, polymorphic: true
  attr_accessible :legatee_id, :legatee_type, :legator_id, :legator_table
end
