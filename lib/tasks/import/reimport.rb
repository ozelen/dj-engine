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

  def reimport_bookit_ids
    puts "Reimport IDs #{BookitObject.count}"
    BookitHotel.all.each do |obj|
      I18n.locale = :ru
      legacy = SkiworldLegacy.where(legator_id: obj.djObjId, legator_table: 'Objects')[0]
      if legacy && legacy.legatee
        #puts "#{obj.name} -> [#{obj.djObjId}] #{(legacy ? legacy.legatee.name : '')}"
        hotel = legacy.legatee
        hotel.leads[0].params = obj.attributes.to_json
        hotel.save
      end
    end
  end

end

