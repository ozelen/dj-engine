namespace :import do
  class Agreement < HotelBase
    set_table_name 'Agreements'
    set_primary_key 'Id'

    def self.find_by_object_id id
      where("ObjId = #{id}")
    end

    def number
      "#{self.Ser} #{self.Number}"
    end

    def person_name
      "#{self.FirstName} #{self.Patronymic} #{self.LastName}"
    end

    def contacts
      self.Contacts
    end

    def begin_date
      self.BeginDate
    end

    def expire_date
      self.Expire
    end

    def status
      self.Status
    end

    def price
      self.Price
    end

    def attributes new_object_id
      {
          begin_date:       begin_date,
          expire_date:      expire_date,
          contacts:         contacts,
          dealable_id:      new_object_id,
          dealable_type:    'Hotel',
          login:            login,
          password:         password,
          person_name:      person_name,
          price:            price,
          status:           status
      }
    end

  end
end
