require 'rails_helper'

RSpec.describe ShortenerController, type: :controller do
  describe 'create' do
    context 'when the request contains a url' do
      let(:params) do
        { full_url: "www.facebook.com" }
      end

      before do
        post :create, params: params
      end

      it 'returns a 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to the url view page' do
        short_url = Rack::Utils.parse_query(URI.parse(response.location).query)['short_url']
        expect(response).to redirect_to :controller => 'url', :action => 'index', short_url: short_url
      end
    end


    context 'when the full_url is missing' do
      let(:params) do
        {  }
      end

      before do
        post :create, params: params
      end

      it 'returns a 400' do
        expect(response.status).to eq 400
      end

      it 'contains a useful error message' do
        expect(JSON.parse(response.body)['message']).to eq 'param is missing or the value is empty: full_url'
      end
    end

    context 'when something exceptional happens' do
      let(:params) do
        { full_url: "www.facebook.com" }
      end

      before do
        allow(ShortUrl).to receive(:new).and_raise(StandardError)
        post :create, params: params
      end

      it 'returns a 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to the error page' do
        expect(response).to redirect_to :controller => 'error', :action => 'index'
      end
    end
  end

  describe 'show' do
    context 'when looking up a saved url' do

      let(:post_params) do
        {full_url: 'https://www.twitter.com' }
      end
      before do
        post :create, params: post_params
        short_url = Rack::Utils.parse_query(URI.parse(response.location).query)['short_url']
        get :show, params: { id: short_url }
      end

      it 'redirects the user' do
        expect(response.status).to eq 302
      end

      it 'redirects to the full_url' do
        expect(response).to redirect_to 'https://www.twitter.com'
      end

    end

    context 'when the short url is not in the database' do
      let(:params) do
        { id: "InvalidID" }
      end

      before do
        test = ShortUrl.new({ full_url: 'www.discogs.com'})
        test.save
        get :show, params: params
      end

      it 'returns a 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to the not found page' do
        expect(response).to redirect_to :controller => 'notfound', :action => 'index'
      end
    end

    context 'when something exceptional happens' do
      let(:params) do
        { id: "2Bj" }
      end
      before do
        allow(ShortUrl).to receive(:load_by_short_url).and_raise(StandardError)
        get :show, params: params
      end

      it 'returns a 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to the error page' do
        expect(response).to redirect_to :controller => 'error', :action => 'index'
      end
    end
  end

  describe "GET #index" do
    before do
      get :index
    end

    it 'gets the page' do
      expect(response).to have_http_status(:success)
    end
  end

end
