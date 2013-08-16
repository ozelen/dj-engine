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

    class PageData
      def initialize(data)
        @data = data
      end

      def locale loc
        @data.select {|d| d.Lang == loc}[0]
      end

      def ru
        self.locale :ru
      end
      def ua
        self.locale :ua
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

    ### Classification

    class ClassLink < SkiWorld
      set_table_name 'ClassLinks'
      def key
        SwPage.find(self.ClassKey) rescue nil
      end
      def value
        SwPage.find(self.ClassValue) rescue nil
      end
      def name
        self.value.data.title('ru') || 'noname'
      end
    end

    ###

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
        classes.each do |c|
          #puts " * #{c.key.data.title('ru')}:#{c.value.data.title('ru')} "
          puts " * #{c.key.name}:#{c.value.name} "
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

      def typical_name
        self.caption.value rescue nil
      end

      def profile_name
        self.profile.value rescue nil
      end

      def name
        self.page.data.title 'ru'
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


    ### ACTION ###

    def hr length=100, sym='-'
      line = ""
      1.upto(length){|i| line+=sym}
      puts line
    end


    Type.delete_all
    Field.delete_all

    hotel_type = Type.create(name: 'Hotel', slug: 'hotels', filter: 'Hotel');
    SwPage.where("Rozdil = 357").each do |p|
      subtype = hotel_type.children.create(slug: p.name)

      [:ru, :ua, :en].each do |loc|
        I18n.locale = loc == :ua ? :uk : loc
        name = p.data.title(loc)
        unless name.blank?
          subtype.name = name
          subtype.save!
        end
      end


      I18n.locale = :uk
      subtype.name = p.data.title(:ua)
      subtype.save!

    end

    #hr 100, '#'
    #HbObject.limit(20).each do |o|
    #  puts "Object##{o.Id}    #{o.content.title('ru')} [#{o.slug}]"
    #  puts "Profile:      hotels"
    #  puts "Type:         recreation-centre"
    #  puts "Properties:"
    #  o.show_classes
    #  o.hb_categories.each do |c|
    #    pref = (c.profile.value.name rescue '') == 'rooms' ? 'room   ' : 'service'
    #    puts "#{pref}       #{c.content.title 'ru'} /#{c.caption.value.name rescue ''}/ "
    #    c.show_classes
    #    hr 40, '`'
    #  end
    #  hr 50, '.'
    #end
    ###


  end
end