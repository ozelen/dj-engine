namespace :import do
  desc 'import the legacy db data'
  task hotelbase: :environment do

    ### Databases
    class HotelBase < ActiveRecord::Base
      self.abstract_class = true
      establish_connection :hotelbase
    end

    class SkiWorld < ActiveRecord::Base
      self.abstract_class = true
      establish_connection :skiworld
    end
    ###

    ### Pages ###
    class ContentPage < ActiveRecord::Base
      self.abstract_class = true
      set_table_name 'Pages'
      set_primary_key 'Id'

      def content
        HbPageData.where("PageId = #{self.id} and Lang = 'ua' ").first
      end
    end

    class HbPage < ContentPage
      establish_connection :hotelbase
    end

    class SwPage < ContentPage
      establish_connection :skiworld
    end

    class HbPageData < HotelBase
      set_table_name 'PageData'
      set_primary_key 'PageId, Lang'
      belongs_to :hb_page, foreign_key: 'PageId'
    end
    ###

    ### Classification



    ###

    ### Objects ###
    class HbObjective < HotelBase
      self.abstract_class = true
      def page
        HbPage.find(self.PageId) rescue nil
      end
    end

    class HbObject < HbObjective
      set_table_name 'Objects'
      set_primary_key 'Id'

      has_many :hb_categories, foreign_key: 'ObjId'
    end

    class HbCategory < HbObjective
      set_table_name 'Categories'
      set_primary_key 'Id'

      belongs_to :hb_object, foreign_key: 'ObjId'
    end
    ###


    ### ACTION ###
    HbObject.all.each do |o|
      obj_name = o.page.content.Title
      puts obj_name
      o.hb_categories.each do |c|
        cat_name = c.try(:page).try(:content).try(:Title) || 'noname'
        puts  '--' + cat_name
      end
    end
    ###

  end
end