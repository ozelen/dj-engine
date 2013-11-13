class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  attr_accessible :addr, :addressable_id, :addressable_type, :email, :fax, :phone1, :phone2, :phone3, :skype, :website
  translates :addr
end
