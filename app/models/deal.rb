class Deal < ActiveRecord::Base
  belongs_to :dealable, polymorphic: true
  attr_accessible :begin_date, :contacts, :dealable_id, :dealable_type, :expire_date, :login, :password, :person_name, :price, :status
end
