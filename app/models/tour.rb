class Tour < ActiveRecord::Base
  belongs_to :user
  has_one :gallery, as: :imageable,   dependent: :destroy
  has_many :locations, as: :located,  dependent: :destroy
  has_many :hotel_tour_assignments,   dependent: :destroy
  has_many :resort_tour_assignments,  dependent: :destroy
  has_many :hotels,  through: :hotel_tour_assignments
  has_many :resorts, through: :resort_tour_assignments
  has_one :address, as: :addressable

  accepts_nested_attributes_for :hotel_tour_assignments, allow_destroy: true
  accepts_nested_attributes_for :resort_tour_assignments, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true
  attr_accessible :description, :name, :slug, :user_id, :hotel_tour_assignments_attributes, :resort_tour_assignments_attributes, :address_attributes, :portal_list


  acts_as_commentable
  acts_as_taggable_on :portals
  after_create :create_gallery

  def to_param
    "#{id} #{slug}".parameterize
  end
end
