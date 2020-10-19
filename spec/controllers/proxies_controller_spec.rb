require 'rails_helper'

describe ProxiesController do
  describe '#get' do
    let(:user) { create(:user, slug: 'bx') }
    let(:proxy) { create(:proxy, slug: 'thighbax-contact', user: user) }
    let!(:cors_host1) { create(:cors_host, host: 'localhost:800', proxy: proxy) }
    let!(:cors_host2) { create(:cors_host, host: 'https://attackofthethighbax.com', proxy: proxy) }
    let(:hosts) { 'localhost:800,https://attackofthethighbax.com' }

    it 'assigns the CORS headers' do
      get :get, params: { user_slug: user.slug, proxy_slug: proxy.slug }

      expect(response.headers['Access-Control-Allow-Origin']).to eq(hosts)
    end
  end
end
