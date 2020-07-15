# == Schema Information
#
# Table name: proxies
#
#  id                  :uuid             not null, primary key
#  body_format         :string
#  name                :string
#  proxy_request_type  :string
#  proxy_url           :text
#  target_request_type :string
#  target_url          :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :uuid
#
class Proxy < ApplicationRecord
  belongs_to :user
  has_many :proxy_params, dependent: :destroy
  has_many :proxy_headers, dependent: :destroy

  accepts_nested_attributes_for :proxy_params, allow_destroy: true
  accepts_nested_attributes_for :proxy_headers, allow_destroy: true

  validates_presence_of :name
end
