namespace :import do
  ### Pages ###

  class PageData
    def initialize(data)
      @data = data
    end

    def locale loc
      @data.select {|d| d.Lang == loc}[0]
    end

    def ru
      self.locale :ru
      self
    end
    def ua
      self.locale :ua
      self
    end

    def get_field loc, name
      self.locale(loc.to_s)[name].force_encoding("UTF-8") rescue nil #"no #{loc} translate"
    end

    def title loc
      self.get_field(loc, 'Title')
    end

    def content loc
      self.get_field loc, 'Source'
    end

  end

  class ContentPage < ActiveRecord::Base
    self.abstract_class = true
    set_table_name 'Pages'
    set_primary_key 'Id'

    def page_data_class
    end

    def page_class
      self
    end

    def data
      raw_data = self.page_data_class.where("PageId = #{self.id} ")
      res = PageData.new(raw_data)
      res
    end

    def content
      self.page_data_class.where("PageId = #{self.id} and Lang = 'ua' ").first
    end

    def name
      self.Name
    end

    def children
      self.class.where("Rozdil = #{self.Id}")
    end

  end

  class HbPage < ContentPage
    establish_connection :hotelbase
    def page_data_class
      HbPageData
    end
  end

  class SwPage < ContentPage
    establish_connection :skiworld
    def page_data_class
      SwPageData
    end
  end

  class HbPageData < HotelBase
    set_table_name 'PageData'
    set_primary_key 'PageId, Lang'
    belongs_to :hb_page, foreign_key: 'PageId'
  end

  class SwPageData < SkiWorld
    set_table_name 'PageData'
    set_primary_key 'PageId, Lang'
    belongs_to :hb_page, foreign_key: 'PageId'
  end
  ###
end