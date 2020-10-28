require 'rails_helper'

describe ProxyRequest do
  describe '#run!' do
    let(:proxy) do
      create(:proxy,
        target_request_type: target_request_type,
        target_url: target_url
      )
    end

    let(:body) { {} }

    subject do
      ProxyRequest.new(proxy: proxy, body: body).run!
    end

    context 'GET request' do
      let(:target_request_type) { 'get' }
      let(:target_url) { 'https://api.foobie.com/lists' }
      let(:stub_url) { target_url }

      before do
        stub_request(:get, stub_url)
      end

      it 'makes the request' do
        subject

        expect(WebMock).to have_requested(:get, target_url)
      end

      context 'body exists' do
        let(:body) { { bar: 'bazie' } }
        let(:stub_url) { "#{target_url}?bar=bazie" }

        it 'includes the body' do
          subject

          expect(WebMock).to have_requested(:get, stub_url)
        end
      end

      context 'headers exist' do
        let!(:header) do
          create(:proxy_header,
            name: 'Content-Type',
            value: 'application/json',
            proxy: proxy
          )
        end

        it 'includes the header' do
          subject

          expect(WebMock).to have_requested(:get, stub_url).with(
            headers: { 'Content-Type' => 'application/json' }
          )
        end
      end
    end

    context 'POST request' do
      let(:target_request_type) { 'post' }
      let(:target_url) { 'https://api.foobie.com/lists' }
      let(:stub_url) { target_url }

      before do
        stub_request(:post, stub_url)
      end

      it 'makes the request' do
        subject

        expect(WebMock).to have_requested(:post, target_url)
      end

      context 'body exists' do
        let(:body) { { bar: 'bazie' } }

        it 'includes the body' do
          subject

          expect(WebMock).to have_requested(:post, stub_url).with(
            body: 'bar=bazie'
          )
        end
      end

      context 'headers exist' do
        let!(:header) do
          create(:proxy_header,
            name: 'Content-Type',
            value: 'application/json',
            proxy: proxy
          )
        end

        it 'includes the header' do
          subject

          expect(WebMock).to have_requested(:post, stub_url).with(
            headers: { 'Content-Type' => 'application/json' }
          )
        end
      end
    end
  end
end
