class ShortenerController < ApplicationController
  before_action only: [:create] do
    params.require(:full_url)
  end

  def show
    shortened = ShortUrl.load_by_short_url(short_url: params[:id])
    full_url = shortened.full_url
    redirect_to full_url
  end

  def create
    url = ShortUrl.new({full_url: params[:full_url]})
    url.save!
    redirect_to :controller => 'url', :action => 'index', short_url: url.short_url
  end

  def hinted_text_field_tag(name, value = nil, hint = "Click and enter text", options={})
    value = value.nil? ? hint : value
    text_field_tag name, value, {:onclick => "if($(this).value == '#{hint}'){$(this).value = ''}", :onblur => "if($(this).value == ''){$(this).value = '#{hint}'}" }.update(options.stringify_keys)
  end
end
