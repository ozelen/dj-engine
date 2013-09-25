namespace :import do

  class BookitLead < HotelBase
    self.abstract_class = true

    set_primary_key 'Id'

    LEGACY_ID = nil

    def self.get_attributes_by_object_id id
      entry = self.where("#{legacy_id} = ?", id)
      entry[0].json if entry.present?
    end

    def attributes
      nil
    end

    def json
      attributes.to_json
    end
  end

  class BookitCity < BookitLead
    set_table_name 'bookit_CitiesSearchForm'
    def self.legacy_id; 'djSettlementId' end

    def attributes
      {
          slug: self.Url,
          name: self.Name
      }
    end
  end

  class BookitHotel < BookitLead
    set_table_name 'bookit_hotelsBookit'
    def self.legacy_id; 'djObjId' end

    def attributes
      {
          name: self.name
      }
    end
  end

end
