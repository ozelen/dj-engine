class LegaciesController < ApplicationController
  before_filter :set_locale

  def set_locale
    I18n.locale = params[:lang] == 'ua' ? :uk : :ru
  end

  def goto
    if params[:goto] =~ /\d.+/
      legacy = SkiworldLegacy.where(legator_id: params[:goto], legator_table: 'Objects')[0]
      redirect_to slug_hotel_url(legacy.legatee) if legacy
    else
      redirect_to "/#{params[:goto]}"
    end
  end
end
