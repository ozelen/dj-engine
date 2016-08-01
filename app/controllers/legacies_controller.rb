class LegaciesController < ApplicationController
  before_filter :set_locale

  def set_locale
    I18n.locale = params[:lang] == 'ua' ? :uk : :ru
  end

  def domain
    request.base_url
  end

  def goto
    if params[:goto] =~ /\d.+/
      legacy = SkiworldLegacy.where(legator_id: params[:goto], legator_table: 'Objects')[0]
      redirect_to legacy ?
        "#{domain}#{slug_hotel_path(legacy.legatee)}" : domain
    else
      # redirect_to "http://besthotels.in.ua/#{params[:goto]}" + (params[:filter_types] ? '/hotels' : '')
      redirect_to: "http://skiworld.org.ua/#{params[:goto]}" + (params[:filter_types] ? '/hotels' : '')
    end
  end

  def city_infrastructure
    @city = Node.find_by_name(params[:city_slug]).accessible
    redirect_to city_hotels_url(@city)
  end

  def news_item
    @post = Post.find_by_slug params[:slug]
    redirect_to (@post ? 'http://besthotels.in.ua' + post_path(@post) : root_url)
  end

end
