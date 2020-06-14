require 'rails_helper'

RSpec.describe UrlController, type: :controller do

  describe "GET #index" do
    context 'when the short_url is missing' do
      before do
        get :index
      end
      it "redirects the user" do
        expect(response).to have_http_status(:redirect)
      end
      it 'redirects the user to the not found page' do
        expect(response).to redirect_to :controller => 'notfound', :action => 'index'
      end
    end

    context 'when the short_url is present' do
      before do
        url = ShortUrl.new({full_url: 'https://www.twitter.com' })
        url.save
        get :index, params: { short_url: '2Bj' }
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:success)
      end

    end
  end

end
