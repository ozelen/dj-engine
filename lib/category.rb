require './lib/category/acts_as_category'

module Category

  def caption
    if name.present? && type.present? && type.parent.present?
      "#{name} (#{type.name})"
    elsif name.present?
      name
    elsif type.present?
      type.name
    end
  end

end