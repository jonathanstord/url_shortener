class UrlController < ApplicationController
  def index
    short_url = ShortUrl.load_by_short_url(short_url: params[:short_url])
    @short_url = Rails.application.config.base_route + '/' + short_url.short_url
  end
end
