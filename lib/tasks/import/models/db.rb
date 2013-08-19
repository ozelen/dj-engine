namespace :import do
  ### Databases
  class HotelBase < ActiveRecord::Base
    self.abstract_class = true
    establish_connection :hotelbase
  end

  class SkiWorld < ActiveRecord::Base
    self.abstract_class = true
    establish_connection :skiworld
  end
  ###
end