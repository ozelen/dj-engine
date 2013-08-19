namespace :import do
  def import_objects
    Hotel.destroy_all
    I18n.locale = :uk
    hr 100, '#'
    HbObject.where('id = 61').each do |o|

      puts "Object##{o.Id}     #{o.content.title('ru')} [#{o.slug}]"
      puts "Type:         #{o.new_class.name}"
      puts "Properties:"

      hotel = Hotel.create(node_attributes: {name: o.AccountCode})
      #hotel.
      [:ru, :ua, :en].each do |loc|
        name  = o.content.title(loc)
        descr = o.content.content(loc)
        I18n.locale = loc == :ua ? :uk : loc

        hotel.node.header = name
        hotel.node.content = descr
        hotel.node.save!

      end

      #o.show_classes
      o.hb_categories.each do |c|
        pref = (c.profile.value.name rescue '') == 'rooms' ? 'room   ' : 'service'
        puts "#{pref}       #{c.content.title 'ru'} /#{c.new_class.name rescue ''}/ "


        c.show_classes
        hr 40, '`'
      end
      hr 50, '.'
    end
  end
end