# == Schema Information
#
# Table name: cors_hosts
#
#  id         :uuid             not null, primary key
#  host       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  proxy_id   :uuid
#
class CorsHost < ApplicationRecord
end
