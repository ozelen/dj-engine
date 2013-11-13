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


  def reimport_addreses

    HbObject.all.each do |o|
      puts o.content.title('ru')
      hotel = SkiworldLegacy.where(legator_table: 'Objects', legator_id: o.Id)[0].legatee
      i=0
      [:ru, :ua, :en].each do |loc|
        I18n.locale = loc == :ua ? :uk : loc


        hotel.address.addr = ReverseMarkdown.parse_string(o.contacts(loc))
        hotel.save

      end


      puts '*** One more ***'
      [:ru, :ua, :en].each do |loc|
        I18n.locale = loc == :ua ? :uk : loc
        hr
        puts hotel.address.addr
      end

    end

  end

end

