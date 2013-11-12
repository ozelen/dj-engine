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
    link_to(name, '#', class: style + " btn btn-default", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def map_for_select array
    array.map{|t| [t, array.index(t)+1] }
  end

  def indent str, level, symbol
    str + symbol * level
  end

  def category_type cat
    cat.type.name unless cat.type.root?
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

  def paginate instance
    will_paginate instance, renderer: BootstrapPagination::Rails, bootstrap: 3
  end

  def find_path(instance, opt_params={})
    case instance
      when Node
        slug_node_path instance.name
      when Hotel
        slug_hotel_path(instance)
      when Room
        slug_hotel_room_path(instance.hotel, instance)
      when Service
        slug_hotel_service_path(instance.hotel, instance)
      when Resort
        slug_resort_path(instance)
      when Stream
        stream_slug_path(instance)
      when Tour
        tour_path(instance)
      when Post
        if params[:stream_slug] then post_path(@stream, instance, opt_params)
        elsif instance.channel_type == 'Resort' then post_path(@resort, instance, opt_params)
        elsif instance.channel then send("#{instance.channel.class.name.parameterize}_post_path", instance.channel, instance, opt_params)  #[instance.channel, instance]
        else; post_path(instance, opt_params); end


      when City
        slug_city_path(instance)
      when Photo
        case instance.gallery.imageable.class.name
          when 'Room'
            room_album_path(@hotel, @room, instance) # special workaround for room and other paths which must have additional variables in their routes (such as hotel slug)
          when 'Post'
            find_path(instance.gallery.imageable, {photo_id: instance.id})
          else
            send("#{instance.gallery.imageable.class.name.parameterize}_album_path", instance.gallery.imageable, instance, anchor: 'album')# rescue '#error'
        end
    end
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

end
