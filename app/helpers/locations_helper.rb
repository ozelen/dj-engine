module LocationsHelper
  def distance_between obj1, obj2, link = nil
    return unless obj1.location
    radius = 1
    distance = obj1.location.distance_to(obj2.location)
    if distance.present?
      distance = distance > radius ? (distance - radius).round(1) : 0
      landmard_name = link ? link_to(obj2.name, link.present?) : obj2.name
      (distance.to_s + ' ' + I18n.translate("units.distance.km_to") + ' ' + landmard_name).html_safe if distance
    end
  end
end
