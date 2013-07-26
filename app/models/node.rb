class Node < ActiveRecord::Base
  belongs_to :accessible, polymorphic: true
  attr_accessible :content, :header, :name, :parent, :title, :accessible_id, :accessible_type
  translates :header, :content, :title

  validates :name, uniqueness: true, presence: true
  before_validation :generate_name

  def self.from_param(param)
    find_by_name!(param)
  end

  def to_param
    name
  end

  def generate_name
    self.name ||= header.parameterize
  end

  def save_from_accessible! params
    self.name = params[:node][:name]
    self.header = params[:node][:header]
    self.content = params[:node][:content]
    self.save!
  end

  def create_from_accessible! params
    Hotel.create(name: params[:node][:name], header: params[:node][:header], content: params[:node][:content])
  end

end
