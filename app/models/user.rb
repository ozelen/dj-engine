class User < ActiveRecord::Base

  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  before_save :remain_roles_for_non_admin, :set_email_to_address

  has_many :hotels
  has_many :assignments
  has_many :authentications, dependent: :destroy
  has_many :posts, as: :channel
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  attr_accessible :username, :password, :email, :first_name, :last_name, :address, :phone, :password_confirmation, :roles, :address_attributes

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def set_email_to_address # ugly workaround, but don't want to extern the email into other (not necessary) model
    address.email = email if address
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

  def admin?
    role? :admin
  end

  def remain_roles_for_non_admin
    if new_record?
      self.roles_mask = nil unless username=='oleksa' and valid?
    else
      this_user = User.find(self.id)
      self.roles_mask = User.find(self.id).roles_mask if !this_user.role? :admin # Work around to omit self setting roles for non admins
    end
  end

  def users_available
    self.role?(:admin) ? User.all : [self]
  end

  def apply_omniauth(auth)
    self.email       ||= auth.email# if email.blank?
    self.username    ||= auth.info.nickname
    self.first_name  ||= auth.info.first_name
    self.last_name   ||= auth.info.last_name
    authentications.build(provider: auth.provider, uid: auth.uid)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def self.find_for_oauth(auth, user_params, signed_in_resource=nil)
    authentication = Authentication.where(:provider => auth.provider, :uid => auth.uid).first
    authentication ? authentication.user : (signed_in_resource || User.create( user_params ))
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user_params = {
        first_name: auth.extra.raw_info.first_name,
        last_name:  auth.extra.raw_info.last_name,
        email:      auth.info.email,
        password:   Devise.friendly_token[0,20]
    }
    find_for_oauth(auth, user_params, signed_in_resource)
  end

  def self.find_for_vk_oauth(auth, signed_in_resource=nil)
    username = auth.info.nickname || auth.extra.screen_name
    username.parameterize if username
    user_params = {
        first_name: auth.extra.raw_info.first_name,
        last_name:  auth.extra.raw_info.last_name,
        email:      auth.info.email,
        username:   username,
        password:   Devise.friendly_token[0,20]
    }
    find_for_oauth(auth, user_params, signed_in_resource)
  end

  def facebook
    token = self.authentications.find_by_provider(:facebook).token
    @facebook ||= Koala::Facebook::API.new(token)
  end

end
