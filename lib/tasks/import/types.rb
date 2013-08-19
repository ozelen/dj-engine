namespace :import do

  def localize entry, page
    [:ru, :ua, :en].each do |loc|
      I18n.locale = loc == :ua ? :uk : loc
      name = page.data.title(loc)
      unless name.blank?
        entry.name = name
        entry.save!
      end
    end
  end

  def import_type type_fields, type_ids_legacy, field_category_ids_legacy
    type = Type.create(type_fields);
    type_ids_legacy.each do |type_id_legacy|
      SwPage.where("Rozdil = #{type_id_legacy}").each do |p|
        subtype = type.children.create(slug: p.name)
        localize subtype, p
      end
    end


    import_type_fields type, field_category_ids_legacy
  end

  def import_type_fields type, category_ids
    category_ids.each do |cat_id|
      cat_page = SwPage.find(cat_id)
      puts cat_page.name
      field_category = type.field_categories.create(name: cat_page.data.title(:ua), slug: cat_page.name)
      localize field_category, cat_page
      SwPage.where("Rozdil = #{cat_id}").each do |field_page|
        puts "  * #{field_page.name}"
        field = field_category.fields.create(name: field_page.data.title(:ua), slug: field_page.name)
        localize field, field_page
      end
    end
  end

  def import_types
    Type.delete_all
    Field.delete_all

    # hotel type with fields
    import_type({name: 'Hotel', slug: 'hotels', filter: 'Hotel'}, [357], [358, 360, 1017])

    # room type with fields
    import_type({name: 'Room', slug: 'rooms', filter: 'Room'}, [378], [379, 381, 382, 383, 545, 1024, 1031, 1039, 1041, 1042])

    # hotel type with fields
    import_type({name: 'Service', slug: 'services', filter: 'Service'}, [432, 361], [])
  end

end