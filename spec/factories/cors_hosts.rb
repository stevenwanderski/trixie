FactoryBot.define do
  factory :cors_host do
    host { 'http://localhost' }
    proxy_id { "" }
  end
end
