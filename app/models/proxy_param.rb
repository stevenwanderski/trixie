# == Schema Information
#
# Table name: proxy_params
#
#  id         :uuid             not null, primary key
#  param_from :string
#  param_to   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  proxy_id   :uuid             not null
#
class ProxyParam < ApplicationRecord
end
