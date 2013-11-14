class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel, polymorphic: true
  has_one :gallery, as: :imageable
  attr_accessible :channel_id, :channel_type, :content, :slug, :teaser, :title, :tag_list, :portal_list
  translates :content, :teaser, :title, fallbacks_for_empty_translations: true
  after_create :create_gallery

  acts_as_commentable
  acts_as_taggable
  acts_as_taggable_on :portals, :tags

  default_scope order('created_at DESC')

  before_save :to_markdown

  def to_markdown
    self.content = ReverseMarkdown.parse_string content
  end

  def name
    title
  end

  def to_param
    "#{id} #{slug}".parameterize
  end


end
