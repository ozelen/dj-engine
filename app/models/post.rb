class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel, polymorphic: true
  has_one :gallery, as: :imageable
  attr_accessible :channel_id, :channel_type, :content, :slug, :teaser, :title, :tag_list
  translates :content, :teaser, :title
  after_create :create_gallery

  acts_as_commentable
  acts_as_taggable
  acts_as_taggable_on :portals, :tags

  def to_param
    "#{id} #{slug}".parameterize
  end
end
