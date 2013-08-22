namespace :import do
  class News < SkiWorld
    set_table_name 'News'
    set_primary_key 'Id'

    def slug
      self.paperId
    end

    def encode text
      text.force_encoding("UTF-8") rescue nil
    end

    def title
      encode self.Name
    end

    def content
      encode self.Source
    end
  end
end