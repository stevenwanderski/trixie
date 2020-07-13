# == Schema Information
#
# Table name: content_types
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
class ContentType < ApplicationRecord
  has_many :fields
  accepts_nested_attributes_for :fields, allow_destroy: true
end
