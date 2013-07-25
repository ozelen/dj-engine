class User < ActiveRecord::Base
  acts_as_authentic
  before_update :remain_roles_for_non_admin

  has_many :hotels
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


  def remain_roles_for_non_admin
    this_user = User.find(self.id)
    self.roles_mask = User.find(self.id).roles_mask if !this_user.role? :admin # Work around to omit self setting roles for non admins
  end


end
