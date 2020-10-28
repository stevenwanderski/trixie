# == Schema Information
#
# Table name: proxy_headers
#
#  id         :uuid             not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  proxy_id   :uuid             not null
#
class ProxyHeader < ApplicationRecord
  belongs_to :proxy
end
