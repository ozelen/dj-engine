class User < ActiveRecord::Base
  acts_as_authentic

  has_many :assignments
  attr_accessible :username, :password, :email, :first_name, :last_name, :address, :phone, :password_confirmation, :roles

  def name
    "#{self.first_name} #{self.last_name}"
  end

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin moderator editor copywriter author]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  #scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  #
  #ROLES = %w[admin moderator author]
  #
  #def roles=(roles)
  #  self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  #end
  #
  #def roles
  #  ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  #end
  #
  #def role?(role)
  #  roles.include? role.to_s
  #end

end
