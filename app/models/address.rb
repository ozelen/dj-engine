class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  attr_accessible :addr, :addressable_id, :addressable_type, :email, :fax, :phone1, :phone2, :phone3, :skype, :website
  translates :addr

  before_save :to_markdown

  def to_markdown!
    self.addr = ReverseMarkdown.parse_string addr
  end
end
