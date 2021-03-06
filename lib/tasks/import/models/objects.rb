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

    def new_fields
      fields = []
      classes.each do |c|
        if c.value
          field = Field.find_by_slug c.value.name
          fields.push field if field
        end
      end
      fields
    end

    def show_classes
      I18n.locale = :uk
      classes.each do |c|
        #puts " ~ #{c.key.data.title('ru')}:#{c.value.data.title('ru')} "
        next unless c.value
        cat = FieldCategory.find_by_slug c.key.name
        fld = Field.find_by_slug c.value.name
        puts " * #{c.key.name}:#{c.value.name} => #{cat.name} : #{fld.name} " if cat and fld
      end
    end

    def class_service_types
      classes.map {|c| Type.find_by_slug(c.value.name) if c.key && c.value && c.value.name!='hotels' && (c.key.name == 'services' || c.key.name == 'entertainments') }
    end

    def location
      LegacyLocations.where("OwnerId = #{self.id} and OwnerTable = 'Objects'")[0]
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

    def root_type
      slug =
          case self.table
            when 'Objects' then 'hotels'
            when 'Categories' then 'rooms'
            else 'services'
          end
      Type.find_by_slug(slug)
    end

    def new_class

      if self.caption && self.caption.value
          Type.find_by_slug(self.caption.value.name) # rescue root_type # hard work around
        else
          self.new_type
      end
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
      self.page.try(:data)
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

    def contacts loc
      content_page('contacts').data.content loc rescue ''
    end

    def periods
      LegacyPeriods.where("ObjId = #{self.Id}")
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

    def prices
      LegacyPrices.where("CatId = #{self.Id}")
    end
  end

  class HbRegion < HbObjective
    set_table_name 'Regions'
    set_primary_key 'Id'

  end

  class HbSettlement < HbObjective
    set_table_name 'Settlements'
    set_primary_key 'id'

    def table
      'Settlements'
    end

    def Id
      id
    end

    def region
      HbRegion.find(region_id) rescue nil
    end

    def district
      HbRegion.find(district_id) rescue nil
    end

  end

  ###

  class LegacyLocations < HotelBase
    set_table_name 'Locations'

  end

  class LegacyPeriods < HotelBase
    set_table_name 'Periods'

    def since
      self.Begin
    end

    def till
      self.End
    end
  end

  class LegacyPrices < HotelBase
    set_table_name 'Prices'

    def by_period period_id
      self.where("PerId = #{period_id}")
    end

    def by_category category_id
      self.where("CatId = #{category_id}")
    end
  end

end