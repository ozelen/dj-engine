namespace :import do

  def reimport_albums
    HbObject.all.each do |o|

      object_photos_dir     = "public/legacy/hotcat/objects/#{o.Id}"
      object_album_dir      = object_photos_dir+'/albums/album'
      gallery               = find_gallery(o, 'Objects')

      hotel = SkiworldLegacy.where("legator_id = ? and legator_table = ?", o.Id, 'Objects')[0].legatee

      if hotel && hotel.gallery.photos.count == 0
        import_images(hotel, object_album_dir, gallery)
      end


    end
  end

end

