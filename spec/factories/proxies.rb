FactoryBot.define do
  factory :proxy do
    name { 'Funky Proxy' }
    proxy_request_type  { 'get' }
    slug { 'thighbax-contact' }
    target_request_type { 'get' }
    target_url { 'https://jsonplaceholder.typicode.com:443/posts/1' }
    user
  end
end
