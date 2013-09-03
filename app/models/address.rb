class Address < ActiveRecord::Base
  attr_accessible :address, :addressable_id, :addressable_type, :email, :fax, :phone1, :phone2, :phone3, :skype, :website
end
