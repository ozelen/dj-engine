namespace :import do

  def import_objects
    Hotel.destroy_all
    City.destroy_all
    cities_index = [] # indexing cities not to call db every time

    I18n.locale = :uk
    hr 100, '#'

    import_cities cities_index

    HbObject.all.each do |o|
      puts "Object##{o.Id}     #{o.content.title('ru')} [#{o.slug}]"
      puts "Type:         #{o.new_class.name}"      rescue nil
      puts "Profile:      #{o.new_prof.root.name}"  rescue nil
      puts "Properties:   #{o.new_fields.inspect}"  rescue nil

      # photos path
      object_photos_dir     = "public/uploads/legacy/#{o.Id}"
      object_album_dir      = object_photos_dir+'/albums/album'
      object_categories_dir = object_photos_dir+'/categories'

      hotel = obj_create o

      if o.Settlement && cities_index[o.Settlement]
        hotel.city_id = cities_index[o.Settlement]
        hotel.save!
      end

      puts "City: #{hotel.city_id}"
      classify hotel, o.new_fields

      hotel.save

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

  def import_cities cities_index
    HbSettlement.where("PageId is not null").each do |c|
      new_city = obj_create(c)
      cities_index[c.id] = new_city.id if new_city
    end
  end

  def obj_create legacy_object
    profile = ''

    if legacy_object.instance_of? HbCategory
      profile = legacy_object.new_prof.root.slug rescue 'services'
      klass = profile == 'rooms' ? Room : Service
      new_object = klass.create!(skiworld_legacy_attributes: { legator_id: legacy_object.Id, legator_table: 'Categories' })
    else

      location = if legacy_object.location
                   legacy_object.location
                 elsif legacy_object.respond_to? :lat, :lng
                   legacy_object
                 end

      location_attributes = { latitude:  location.lat, longitude: location.lng } if location

      if legacy_object.instance_of? HbObject
        slug = legacy_object.AccountCode.blank? ? legacy_object.Id : legacy_object.AccountCode
        puts "slug: #{slug}"
        slug = Node.find_by_name(slug.to_s) ? "#{slug}_d_#{legacy_object.Id}" : slug
        # TODO: substitute escapeHTML to sanitize after migration on rails 4
        puts "Create hotel #{slug}"
        new_object = Hotel.new(
            node_attributes: {name: slug},
            address_attributes: { email:  Sanitize.clean(legacy_object.Email), phone1: Sanitize.clean(legacy_object.Mob), phone2: Sanitize.clean(legacy_object.Phones) },
            skiworld_legacy_attributes: { legator_id: legacy_object.Id, legator_table: 'Objects' },
            lead_attributes: { provider: 'nezabarom', params: BookitHotel.get_attributes_by_object_id(legacy_object.Id) }
        )

        new_object.location_attributes = location_attributes if location_attributes.present?

        deals = Agreement.find_by_object_id legacy_object.Id
      #  deals_array = []

        deals.map! {|deal| deal.attributes(new_object.id) if deal.present?}
=begin
        deals.each do |deal|
          deals_array.push  deal.attributes(new_object.id) if deal.present?
        end
=end
        new_object.deals_attributes = deals
        new_object.save

        comments = LegacyComment.get_by_topic(legacy_object.Topic)
        puts "Importing comments (#{comments.count})"
        comments.each do |comment|
          puts "#{comment.Title}\n#{comment.Content}\n---"
          user = nil
          commenter_email   = comment.Email
          commenter_name    = comment.Username
          commenter_email ||= find_email(comment.Content)[0] rescue nil
          commenter_name  ||= username_from_email(commenter_email) rescue nil
          if commenter_email.present?
            user   = User.find_by_email(commenter_email)
            user ||= User.new(email: commenter_email, username: commenter_name)
            if user.valid?
              user.save
            else
              user = nil
            end
          end
          user_id = user.present? ? user.id : nil
          puts "commenter: #{commenter_name} user: #{user_id} email: #{commenter_email}"
          new_comment = Comment.new( commentable: new_object, title: comment.Title, body: comment.Content)

          if user.present?
            new_comment.user_id = user.id
          elsif commenter_name.present?
            new_comment.username = commenter_name
          else
            new_comment.username = 'Anonymous'
          end

          new_comment.save if new_comment.valid?

        end

      elsif legacy_object.instance_of? HbSettlement
        return unless legacy_object.Ident
        puts "Importing city #{legacy_object.title('ru')}"
        location_attributes.merge({ address: [legacy_object.name, legacy_object.district, legacy_object.region].select{|x| x if x.present? }.join(', ') })
        new_object = City.create!(
            node_attributes: {name: legacy_object.Ident},
            location_attributes: location_attributes,
            skiworld_legacy_attributes: { legator_id: legacy_object.Id, legator_table: 'Cities' },
            lead_attributes: { provider: 'nezabarom', params: BookitCity.get_attributes_by_object_id(legacy_object.Id) }
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
    #return # skip for a while, because toooo long
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