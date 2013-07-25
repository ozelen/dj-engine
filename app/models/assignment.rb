class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :assigned, polymorphic: true
  attr_accessible :assigned_id, :assigned_type, :role, :user_id
end
