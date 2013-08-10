class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  before_update :remain_roles_for_non_admin

  has_many :hotels
  has_many :assignments

  has_many :authentications

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

  def users_available
    if self.role? :admin
      User.all
    else
      [self]
    end
  end

end
