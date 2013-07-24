class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :password, :email, :first_name, :last_name, :address, :phone, :password_confirmation

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
