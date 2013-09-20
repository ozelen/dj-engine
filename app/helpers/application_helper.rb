module ApplicationHelper
  def page_title
    (@page_title + " &mdash; " if @content_for_title).to_s + 'My Cool Site'
  end

  def page_heading(text)
    content_tag(:h1, content_for(:title){ text })
  end

  def link_to_add_fields(name, f, association, style = 'add_fields')
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: style + " btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def map_for_select array
    array.map{|t| [t, array.index(t)+1] }
  end

  def indent str, level, symbol
    str + symbol * level
  end

  def markdown(text, options=nil)
    return unless text

    options ||= {
        hard_wrap: true,
        filter_html: true,
        autolink: true,
        no_intraemphasis: true,
        tables: true,
        quote: true
    }

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(hard_wrap: true), options)
    markdown.render(text).html_safe

  end

  #def channel_url
  #  channel = controller.controller_name.singularize
  #  comments_path(channel_type: channel, channel_id: controller.instance_variable_get("@#{channel}").node.name)
  #end

end
