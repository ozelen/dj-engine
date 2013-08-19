namespace :import do
  def import_objects
    hr 100, '#'
    HbObject.limit(20).each do |o|
      puts "Object##{o.Id}    #{o.content.title('ru')} [#{o.slug}]"
      puts "Profile:      hotels"
      puts "Type:         recreation-centre"
      puts "Properties:"
      o.show_classes
      o.hb_categories.each do |c|
        pref = (c.profile.value.name rescue '') == 'rooms' ? 'room   ' : 'service'
        puts "#{pref}       #{c.content.title 'ru'} /#{c.caption.value.name rescue ''}/ "
        c.show_classes
        hr 40, '`'
      end
      hr 50, '.'
    end
  end
end