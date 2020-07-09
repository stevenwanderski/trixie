class ContentType < ApplicationRecord
  has_many :fields
  accepts_nested_attributes_for :fields, allow_destroy: true
end
