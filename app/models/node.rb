class Node < ActiveRecord::Base
  belongs_to :accessible, polymorphic: true, dependent: :destroy
  attr_accessible :content, :header, :name, :parent, :title, :accessible_id, :accessible_type, :to_markdown
  translates :header, :content, :title

  validates :name, uniqueness: true, presence: true
  before_validation :generate_name
  before_save :to_markdown!

  #default_scope with_translations(I18n.locale).order('node_translations.header ASC') # makes terrible mistakes

  def to_markdown
    @to_markdown
  end

  def to_markdown=(bool)
    @to_markdown = bool
  end

  def to_markdown!
    self.content = ReverseMarkdown.parse_string content if @to_markdown == '1' || @to_markdown == 'true'
  end

  def self.from_param(param)
    find_by_name!(param)
  end

  #def to_param
  #  name
  #end

  def generate_name
    self.name ||= header ? header.parameterize : id
  end

  def save_from_accessible! params
    params['node']
    #self.name = params[:node][:name] if params[:node][:name]
    #self.header = params[:node][:header] if params[:node][:header]
    #self.title = params[:node][:title] if params[:node][:title]
    #self.content = params[:node][:content] if params[:node][:content]
    self.save!
  end

  def create_from_accessible! params
    Node.create(name: params[:node][:name], header: params[:node][:header], content: params[:node][:content], title: params[:node][:title])
  end

end
