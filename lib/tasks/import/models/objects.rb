namespace :import do
  ### Objects ###
  class HbObjective < HotelBase
    self.abstract_class = true

    def table
    end

    def page
      HbPage.find(self.PageId) rescue nil
    end
    def classes
      ClassLink.where("OwnerId = #{self.Id} and OwnerTable = '#{self.table}'")
    end
    def show_classes
      I18n.locale = :uk
      classes.each do |c|
        #puts " * #{c.key.data.title('ru')}:#{c.value.data.title('ru')} "
        cat = FieldCategory.find_by_slug c.key.name
        fld = Field.find_by_slug c.value.name
        puts " * #{c.key.name}:#{c.value.name} => #{cat.name} : #{fld.name} " if cat and fld
      end
    end

    def type
      self.classes.select{|c| c.TypeOf==self.table }[0]
    end

    def caption
      self.classes.select{|c| c.NameOf==self.table }[0]
    end

    def profile
      self.classes.select{|c| c.ProfileOf==self.table }[0]
    end

    def new_class
      self.caption ? Type.find_by_slug(self.caption.value.name) : self.new_type
    end

    def new_type
      Type.find_by_slug(self.type.value.name) || self.new_prof rescue nil
    end

    def new_prof
      Type.find_by_slug(self.profile.value.name) rescue nil
    end

    def typical_name
      self.caption.value rescue nil
    end

    def profile_name
      self.profile.value rescue nil
    end

    def name
      self.page.data.title 'ru'
    end

    def title loc
      self.page.data.title loc
    end

    def info loc
      self.page.data.content loc
    end

    def content_page name
      page.children.select {|c| c.Name == name }[0]
    end

    def content
      self.page.data
    end

    def console_title
      "[#{self.id}] #{self.name} [#{self.profile_name}]"
    end

  end

  class HbObject < HbObjective
    def table
      'Objects'
    end

    def slug
      self.AccountCode
    end

    # redefine method because object's info is in nested page
    def info loc
      content_page('info').data.content loc rescue ''
    end

    set_table_name 'Objects'
    set_primary_key 'Id'

    has_many :hb_categories, foreign_key: 'ObjId'
  end

  class HbCategory < HbObjective
    def table
      'Categories'
    end

    set_table_name 'Categories'
    set_primary_key 'Id'

    belongs_to :hb_object, foreign_key: 'ObjId'

    def console_title
      "[#{self.id}] #{self.name} /#{self.typical_name}/ [#{self.profile_name}]"
    end
  end
  ###
end