require "./lib/poi/acts_as_poi"

module Poi
  class Poi
    def slug
      node.name
    end

    def slug=(slug)
      node.name=slug
    end
  end
end