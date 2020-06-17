require 'rails_helper'
require 'base62-rb'

RSpec.describe ShortUrl, type: :model do
  describe '#create' do
    context 'when creating a new url' do
      let(:short) { described_class.new({ full_url: 'www.google.com'}) }
      it 'generates a proper short url upon creation' do
        expect(short.short_url).to eq Base62.encode(short.id + Rails.application.config.encode_padding)
        expect(short.full_url).to eq 'http://www.google.com'
      end
    end
  end

  describe '#load_by_short_url' do
    context 'when the url is in the DB' do
      let(:entry) do
        test = described_class.new({ full_url: 'www.amazon.com'})
        test.save
        test.short_url
      end
      it 'loads the correct url based on the short url' do
        expect(ShortUrl.load_by_short_url(short_url: entry).full_url).to eq 'http://www.amazon.com'
      end
    end

    context 'when the url does not match any records' do
      it 'loads the correct url based on the short url' do
        expect{ShortUrl.load_by_short_url(short_url: 'NotAURL').full_url}.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end
end
