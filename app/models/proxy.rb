# == Schema Information
#
# Table name: proxies
#
#  id                  :uuid             not null, primary key
#  body_format         :string
#  name                :string
#  proxy_request_type  :string
#  proxy_url           :text
#  slug                :string
#  target_request_type :string
#  target_url          :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :uuid
#
class Proxy < ApplicationRecord
  belongs_to :user
  has_many :cors_hosts, dependent: :destroy
  has_many :proxy_params, dependent: :destroy
  has_many :proxy_headers, dependent: :destroy

  accepts_nested_attributes_for :cors_hosts, allow_destroy: true
  accepts_nested_attributes_for :proxy_headers, allow_destroy: true
  accepts_nested_attributes_for :proxy_params, allow_destroy: true

  validates :name, presence: true
  validates :slug, uniqueness: { scope: :proxy_request_type }
end
