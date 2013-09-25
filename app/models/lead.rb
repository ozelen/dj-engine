class Lead < ActiveRecord::Base
  belongs_to :leader, polymorphic: true
  attr_accessible :leader_id, :leader_type, :params, :provider
end
