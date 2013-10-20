module Category
  module ActsAsCategory
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_category(options = {})
        # your code will go here
        include Category::ActsAsCategory::LocalInstanceMethods
      end
    end

    module LocalInstanceMethods
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
  end
end

ActiveRecord::Base.send :include, Category::ActsAsCategory