String.class_eval do
  require 'rexml/parsers/pullparser'

  def indent(count, char = ' ')
    gsub(/([^\n]*)(\n|$)/) do |match|
      last_iteration = ($1 == "" && $2 == "")
      line = ""
      line << (char * count) unless last_iteration
      line << $1
      line << $2
      line
    end

  end

  def trunc

  end

  def truncate_html(len = 30, at_end = nil)
    p = REXML::Parsers::PullParser.new(self.force_encoding("UTF-8"))
    tags = []
    new_len = len
    results = ''
    while p.has_next? && new_len > 0
      p_e = p.pull.self.force_encoding("UTF-8")
      case p_e.event_type
        when :start_element
          tags.push p_e[0]
          results << "<#{tags.last}#{attrs_to_s(p_e[1])}>"
        when :end_element
          results << "</#{tags.pop}>"
        when :text
          results << p_e[0][0..new_len]
          new_len -= p_e[0].length
        else
          results << "<!-- #{p_e.inspect} -->"
      end
    end
    if at_end
      results << "..."
    end
    tags.reverse.each do |tag|
      results << "</#{tag}>"
    end
    results
  end

  private

  def attrs_to_s(attrs)
    if attrs.empty?
      ''
    else
      ' ' + attrs.to_a.map { |attr| %{#{attr[0]}="#{attr[1]}"} }.join(' ')
    end
  end

end