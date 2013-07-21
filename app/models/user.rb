class User < ActiveRecord::Base
  attr_accessible :username, :password, :email, :first_name, :last_name, :address, :phone
end
