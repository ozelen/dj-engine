class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel, polymorphic: true
  attr_accessible :channel_id, :channel_type, :content, :slug, :teaser, :title
  translates :content, :teaser, :title

  def to_param
    "#{id} #{slug}".parameterize
  end
end
