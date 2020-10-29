require 'rails_helper'

describe ProxiesController do
  let(:user) { create(:user, slug: 'bx') }
  let(:target_url) { 'https://api.foo.com' }
  let(:target_request_type) { 'get' }
  let(:origin) { 'https://attackofthethighbax.com' }
  let!(:cors_host1) { create(:cors_host, host: 'localhost:800', proxy: proxy) }
  let!(:cors_host2) { create(:cors_host, host: 'https://attackofthethighbax.com', proxy: proxy) }

  let(:proxy) do
    create(:proxy,
      slug: 'thighbax-contact',
      user: user,
      target_url: target_url,
      target_request_type: target_request_type
    )
  end

  describe '#get' do
    let(:target_request_type) { :get }
    let(:data) { nil }

    subject do
      get :get, params: { user_slug: user.slug, proxy_slug: proxy.slug, data: data }
    end

    describe 'CORS header / request origin' do
      context 'when a match exists' do
        it 'assigns the matching CORS header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(origin)
        end
      end

      context 'when a match does not exist' do
        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = 'http://other.com'

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end

      context 'when no CORS hosts exist' do
        let!(:cors_host1) { nil }
        let!(:cors_host2) { nil }

        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end
    end

    describe 'response' do
      it 'returns the target response body' do
        stub_request(target_request_type, target_url).and_return({
          body: { foo: 'bar' }.to_json
        })

        subject

        expect(response.body).to eq({ foo: 'bar' }.to_json)
      end

      it 'returns the target response code' do
        stub_request(target_request_type, target_url).to_return({
          status: 201
        })

        subject

        expect(response.status).to eq(201)
      end
    end

    describe 'request data params' do
      let(:data) { { foo: 'bar' } }

      it 'passes the data params to the target request' do
        stub_request(target_request_type, "#{target_url}?foo=bar")

        subject

        expect(WebMock).to have_requested(target_request_type, "#{target_url}?foo=bar")
      end
    end
  end

  describe '#post' do
    let(:target_request_type) { :post }
    let(:data) { nil }

    subject do
      post :post, params: { user_slug: user.slug, proxy_slug: proxy.slug, data: data }
    end

    describe 'CORS header / request origin' do
      context 'when a match exists' do
        it 'assigns the matching CORS header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(origin)
        end
      end

      context 'when a match does not exist' do
        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = 'http://other.com'

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end

      context 'when no CORS hosts exist' do
        let!(:cors_host1) { nil }
        let!(:cors_host2) { nil }

        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end
    end

    describe 'response' do
      it 'returns the target response body' do
        stub_request(target_request_type, target_url).and_return({
          body: { foo: 'bar' }.to_json
        })

        subject

        expect(response.body).to eq({ foo: 'bar' }.to_json)
      end

      it 'returns the target response code' do
        stub_request(target_request_type, target_url).to_return({
          status: 201
        })

        subject

        expect(response.status).to eq(201)
      end
    end

    describe 'request data params' do
      let(:data) { { foo: 'bar' } }

      it 'passes the data params to the target request' do
        stub_request(target_request_type, target_url)

        subject

        expect(WebMock).to have_requested(target_request_type, target_url).with({
          body: { foo: 'bar' }
        })
      end
    end
  end

  describe '#put' do
    let(:target_request_type) { :put }
    let(:data) { nil }

    subject do
      put :put, params: { user_slug: user.slug, proxy_slug: proxy.slug, data: data }
    end

    describe 'CORS header / request origin' do
      context 'when a match exists' do
        it 'assigns the matching CORS header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(origin)
        end
      end

      context 'when a match does not exist' do
        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = 'http://other.com'

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end

      context 'when no CORS hosts exist' do
        let!(:cors_host1) { nil }
        let!(:cors_host2) { nil }

        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end
    end

    describe 'response' do
      it 'returns the target response body' do
        stub_request(target_request_type, target_url).and_return({
          body: { foo: 'bar' }.to_json
        })

        subject

        expect(response.body).to eq({ foo: 'bar' }.to_json)
      end

      it 'returns the target response code' do
        stub_request(target_request_type, target_url).to_return({
          status: 201
        })

        subject

        expect(response.status).to eq(201)
      end
    end

    describe 'request data params' do
      let(:data) { { foo: 'bar' } }

      it 'passes the data params to the target request' do
        stub_request(target_request_type, target_url)

        subject

        expect(WebMock).to have_requested(target_request_type, target_url).with({
          body: { foo: 'bar' }
        })
      end
    end
  end

  describe '#patch' do
    let(:target_request_type) { :patch }
    let(:data) { nil }

    subject do
      patch :patch, params: { user_slug: user.slug, proxy_slug: proxy.slug, data: data }
    end

    describe 'CORS header / request origin' do
      context 'when a match exists' do
        it 'assigns the matching CORS header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(origin)
        end
      end

      context 'when a match does not exist' do
        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = 'http://other.com'

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end

      context 'when no CORS hosts exist' do
        let!(:cors_host1) { nil }
        let!(:cors_host2) { nil }

        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end
    end

    describe 'response' do
      it 'returns the target response body' do
        stub_request(target_request_type, target_url).and_return({
          body: { foo: 'bar' }.to_json
        })

        subject

        expect(response.body).to eq({ foo: 'bar' }.to_json)
      end

      it 'returns the target response code' do
        stub_request(target_request_type, target_url).to_return({
          status: 201
        })

        subject

        expect(response.status).to eq(201)
      end
    end

    describe 'request data params' do
      let(:data) { { foo: 'bar' } }

      it 'passes the data params to the target request' do
        stub_request(target_request_type, target_url)

        subject

        expect(WebMock).to have_requested(target_request_type, target_url).with({
          body: { foo: 'bar' }
        })
      end
    end
  end

  describe '#delete' do
    let(:target_request_type) { :delete }
    let(:data) { nil }

    subject do
      delete :delete, params: { user_slug: user.slug, proxy_slug: proxy.slug, data: data }
    end

    describe 'CORS header / request origin' do
      context 'when a match exists' do
        it 'assigns the matching CORS header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(origin)
        end
      end

      context 'when a match does not exist' do
        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = 'http://other.com'

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end

      context 'when no CORS hosts exist' do
        let!(:cors_host1) { nil }
        let!(:cors_host2) { nil }

        it 'does not assign the header' do
          stub_request(:any, target_url)
          request.headers['origin'] = origin

          subject

          expect(response.headers['Access-Control-Allow-Origin']).to eq(nil)
        end
      end
    end

    describe 'response' do
      it 'returns the target response body' do
        stub_request(target_request_type, target_url).and_return({
          body: { foo: 'bar' }.to_json
        })

        subject

        expect(response.body).to eq({ foo: 'bar' }.to_json)
      end

      it 'returns the target response code' do
        stub_request(target_request_type, target_url).to_return({
          status: 201
        })

        subject

        expect(response.status).to eq(201)
      end
    end

    describe 'request data params' do
      let(:data) { { foo: 'bar' } }

      it 'passes the data params to the target request' do
        stub_request(target_request_type, target_url)

        subject

        expect(WebMock).to have_requested(target_request_type, target_url).with({
          body: { foo: 'bar' }
        })
      end
    end
  end
end
