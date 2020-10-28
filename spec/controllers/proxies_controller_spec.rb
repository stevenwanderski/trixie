require 'rails_helper'

describe ProxiesController do
  describe '#get' do
    let(:user) { create(:user, slug: 'bx') }
    let(:proxy) { create(:proxy, slug: 'thighbax-contact', user: user, target_url: target_url) }
    let(:target_url) { 'https://api.foo.com' }
    let(:origin) { 'https://attackofthethighbax.com' }
    let!(:cors_host1) { create(:cors_host, host: 'localhost:800', proxy: proxy) }
    let!(:cors_host2) { create(:cors_host, host: 'https://attackofthethighbax.com', proxy: proxy) }

    context 'CORS header / request origin' do
      context 'when a match exists' do
        it 'assigns the matching CORS header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          get :get, params: { user_slug: user.slug, proxy_slug: proxy.slug }

          expect(response.headers['Access-Control-Allow-Origin']).to eq(origin)
        end
      end

      context 'when a match does not exist' do
        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = 'http://other.com'

          get :get, params: { user_slug: user.slug, proxy_slug: proxy.slug }

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end

      context 'when no CORS hosts exist' do
        let!(:cors_host1) { nil }
        let!(:cors_host2) { nil }

        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          get :get, params: { user_slug: user.slug, proxy_slug: proxy.slug }

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end
    end
  end
end
