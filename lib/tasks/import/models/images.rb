namespace :import do
  class LegacyImages < HotelBase
    set_table_name 'Images'
    set_primary_key 'Id'

    def title?
      LegacyGalleries.find(self.AlbumId).present?
    end
  end

  class LegacyGalleries < HotelBase
    set_table_name 'Modules'
    set_primary_key 'Id'

    def images
      LegacyImages.where("AlbumId = ?", Id)
    end
  end

end