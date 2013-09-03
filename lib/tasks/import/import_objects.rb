namespace :import do
  def import_objects
    Hotel.destroy_all
    I18n.locale = :uk
    hr 100, '#'
    # .where('id = 61') # bungalo
    # ('Id >= 510 and Id <= 520')
    HbObject.where('Id = 512').each do |o|

      puts "Object##{o.Id}     #{o.content.title('ru')} [#{o.slug}]"
      puts "Type:         #{o.new_class.name}"      rescue nil
      puts "Profile:      #{o.new_prof.root.name}"  rescue nil
      puts "Properties:   #{o.new_fields.inspect}"  rescue nil

      # photos path
      object_photos_dir     = "public/uploads/legacy/#{o.Id}"
      object_album_dir      = object_photos_dir+'/albums/album'
      object_categories_dir = object_photos_dir+'/categories'

      hotel_photos = images_in(object_album_dir)

      hotel = obj_create o
      classify hotel, o.new_fields

      hotel_photos.each do |path|
        file = File.open path
        hotel.gallery.photos.new(image: file)
      end
      hotel.save

      o.hb_categories.each do |c|
        pref = (c.profile.value.name rescue '') == 'rooms' ? 'room   ' : 'service'
        puts "#{pref}       #{c.content.title 'ru'} /#{c.new_class.name rescue ''}/ #{c.new_prof.root.name rescue 'no class'} "

        new_category = obj_create c
        new_category.hotel_id = hotel.id
        new_category.save
        classify new_category, c.new_fields

        c.show_classes
        hr 40, '`'
      end

      hr 50, '.'
    end
  end

  def classify object, fields
    fields.each do |field|
      object.values.create(field_id: field.id)
    end
  end

  def obj_create legacy_object
    profile = ''
    if legacy_object.instance_of? HbObject
      slug = legacy_object.AccountCode.blank? ? legacy_object.Id : legacy_object.AccountCode
      new_object = Hotel.create!(node_attributes: {name: slug})
      puts new_object.inspect
    elsif legacy_object.instance_of? HbCategory
      profile = legacy_object.new_prof.root.slug rescue 'services'
      if profile == 'rooms'
        new_object = Room.create!
      else
        new_object = Service.create!
      end
    end

    type = legacy_object.new_class || Type.find_by_slug(profile) || Type.find_by_slug('services')
    new_object.type_id = type.id

    [:ru, :ua, :en].each do |loc|
      name  = legacy_object.title(loc)
      descr = legacy_object.info(loc)

      I18n.locale = loc == :ua ? :uk : loc

      new_object.name = name
      new_object.description = descr
      new_object.save!
      #puts "#{loc}: #{name}\n# Descr: #{descr}\n\n"
    end
    new_object.save!
    new_object
  end

  def images_in directory
    arr = []
    if File.directory?(directory)
      Dir.foreach(directory) do |dir|
        f_path = "#{directory}/#{dir}/big.jpg"
        arr.push f_path if File.exist?(f_path)
      end
    end
    arr
  end

end