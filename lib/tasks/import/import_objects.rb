namespace :import do

  def import_objects
    Hotel.destroy_all
    City.destroy_all
    cities_index = [] # indexing cities not to call db every time

    I18n.locale = :uk
    hr 100, '#'

    HbSettlement.where("PageId is not null").each do |c|
      new_city = obj_create(c)
      cities_index[c.id] = new_city.id if new_city
    end

    HbObject.where("Id = 512").each do |o|
      puts "Object##{o.Id}     #{o.content.title('ru')} [#{o.slug}]"
      puts "Type:         #{o.new_class.name}"      rescue nil
      puts "Profile:      #{o.new_prof.root.name}"  rescue nil
      puts "Properties:   #{o.new_fields.inspect}"  rescue nil

      # photos path
      object_photos_dir     = "public/uploads/legacy/#{o.Id}"
      object_album_dir      = object_photos_dir+'/albums/album'
      object_categories_dir = object_photos_dir+'/categories'

      hotel = obj_create o

      if o.Settlement and cities_index[o.Settlement]
        hotel.city_id = cities_index[o.Settlement]
        hotel.save!
      end

      puts "City: #{hotel.city_id}"
      classify hotel, o.new_fields

      periods_index = import_periods!(hotel, o)

      import_images(hotel, object_album_dir, find_gallery(o, 'Objects'))

      o.hb_categories.each do |c|
        next unless c.content
        pref = (c.profile.value.name rescue '') == 'rooms' ? 'room   ' : 'service'
        puts "[#{c.Id}] #{pref}       #{c.content.title 'ru'} /#{c.new_class.name rescue ''}/ #{c.new_prof.root.name rescue 'no class'} "

        new_category = obj_create c
        new_category.hotel_id = hotel.id
        new_category.save
        classify new_category, c.new_fields
        c.show_classes

        import_prices(new_category, c, periods_index) if new_category.instance_of? Room

        category_album_dir = object_categories_dir+"/#{c.Id}/album"
        import_images(new_category, category_album_dir, find_gallery(c, 'Categories'))
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

    if legacy_object.instance_of? HbCategory
      profile = legacy_object.new_prof.root.slug rescue 'services'
      if profile == 'rooms'
        new_object = Room.create!
      else
        new_object = Service.create!
      end

    else

      location = if legacy_object.location
                   legacy_object.location
                 elsif legacy_object.respond_to? :lat, :lng
                   legacy_object
                 else
                   {lat:nil,lng:nil}
                 end

      location_attributes = {
          latitude:  location.lat,
          longitude: location.lng
      }

      if legacy_object.instance_of? HbObject
        slug = legacy_object.AccountCode.blank? ? legacy_object.Id : legacy_object.AccountCode
        slug = Node.find_by_name(slug) ? "#{slug}_d_#{legacy_object.Id}" : slug
        slug = 'uniqname'
        # TODO: substitute escapeHTML to sanitize after migration on rails 4
        puts "Create hotel #{slug}"
        new_object = Hotel.create!(
            node_attributes: {name: slug},
            address_attributes: {
                email:  Sanitize.clean(legacy_object.Email),
                phone1: Sanitize.clean(legacy_object.Mob),
                phone2: Sanitize.clean(legacy_object.Phones)
            },
            location_attributes: location_attributes
        )

      elsif legacy_object.instance_of? HbSettlement
        return unless legacy_object.Ident
        puts "Importing city #{legacy_object.title('ru')}"
        location_attributes.merge({ address: [legacy_object.name, legacy_object.district, legacy_object.region].select{|x| x if x.present? }.join(', ') })
        new_object = City.create!(
            node_attributes: {name: legacy_object.Ident},
            location_attributes: location_attributes
        )
      end
    end

    type = legacy_object.new_class || Type.find_by_slug(profile) || Type.find_by_slug('services')
    new_object.type_id = type.id unless legacy_object.instance_of? HbSettlement

    [:ru, :ua, :en].each do |loc|
      name  = legacy_object.title(loc)
      descr = legacy_object.info(loc)
      puts "[#{loc}] #{name}"
      I18n.locale = loc == :ua ? :uk : loc

      new_object.name               = Sanitize.clean name
      new_object.description        = ReverseMarkdown.parse_string descr
      new_object.address.address    = ReverseMarkdown.parse_string legacy_object.contacts(loc) if legacy_object.instance_of? HbObject

      new_object.save!
      #puts "#{loc}: #{name}\n# Descr: #{descr}\n\n"
    end
    new_object.save!
    new_object
  end

  def find_gallery legacy_object, object_type
    LegacyGalleries.where("OwnerId = #{legacy_object.Id} and OwnerTable = '#{object_type}'")[0]
  end

  def import_images obj, dir, gallery=nil

    images_in(dir).each do |path|
      tags = (gallery.present? and gallery.TitleImage == path[1]) ? 'title, cover' : nil
      puts "Importing image #{path[1]} #{tags}"
      file = File.open path[0]
      obj.gallery.photos.new(image: file, mode_list: tags)
    end
    obj.save
  end

  def images_in directory
    arr = []
    if File.directory?(directory)
      Dir.foreach(directory) do |dir|
        f_path = "#{directory}/#{dir}/big.jpg"
        arr.push [f_path, dir] if File.exist?(f_path)
      end
    end
    arr
  end

  def import_periods! new_object, legacy_object
    periods_index = []
    legacy_object.periods.each do |p|
      if p.since and p.till
        new_period = new_object.periods.create(since: p.since, till: p.till)
        periods_index.push [p.Id, new_period.id]
      end
    end
    periods_index
  end

  def import_prices new_category, legacy_category, periods_index
    legacy_category.prices.each do |price|
      selected = periods_index.select {|per| per[1] if per[0] == price.PerId }[0]
      if selected
        period_id = selected[1]
        new_category.prices.new(period_id: period_id, value: price.Price)
      end
    end
  end

end