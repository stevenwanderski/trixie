class Proxy < ApplicationRecord
  belongs_to :user

  validates_presence_of :name
end
