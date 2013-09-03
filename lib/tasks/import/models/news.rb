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

    def links
      NewsLinks.where("DocId = #{self.Id}").map do |link|
        case link.tag
          when 'verhovyna.if.ua' then 'verhovyna'
          when 'yarem4e.com' then 'yaremche'
          when 'besthotels.in.ua' then 'best'
          when 'zdravtour.net' then 'zdrav'
          when 'krymtour.net' then 'krym'
          when 'greenworld.com.ua' then 'green'
          when 'skiworld.org.ua' then 'ski'
          else 'ski'
        end
      end
    end
  end

  class NewsLinks < SkiWorld
    set_table_name 'NewsLinks'
    set_primary_key 'DocId, CaseId'
    def tag
      BookCases.find(self.CaseId).Name.force_encoding("UTF-8") rescue nil
    end
  end

  class BookCases < SkiWorld
    set_table_name 'BookCases'
    set_primary_key 'Id'
  end

end