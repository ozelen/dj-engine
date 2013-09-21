module Poi
  module ActsAsPoi

    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def order_by_name
        includes({node: :translations}).order("node_translations.header ASC")
      end

      def acts_as_poi(options = {})

      end

      #def find_by_slug slug
      #  Node.find_by_name(slug).accessible
      #end

      def insp
        self.inspect
      end

    end

  end
end

ActiveRecord::Base.send :include, Poi::ActsAsPoi