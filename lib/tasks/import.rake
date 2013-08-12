namespace :import do
  desc 'import the legacy db data'
  task hotelbase: :environment do
    #class Legacy::Base < ActiveRecord::Base
    #  self.abstract_class = true
    #  establish_connection :hotelbase
    #
    #  acts_as_importable
    #end

    class HBObject < ActiveRecord::Base
      establish_connection :hotelbase
      set_table_name 'Objects'
      set_primary_key 'Id'
    end

    #class HBPage < HotelBase
    #  set_table_name 'Pages'
    #  set_primary_key 'Id'
    #end
    #
    #class HBPageData < HotelBase
    #  set_table_name 'PageData'
    #  set_primary_key 'PageId, Lang'
    #end

    HBObject.all.each do |o|
      puts o.id
      #page = HBPage.find(o.PageId)
      #name = HBPageData.where('PageId = ' + page.id)
      #puts name
      #h = Hotel.create!()
      #hotel.
    end

  end
end