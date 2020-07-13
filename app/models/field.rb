# == Schema Information
#
# Table name: fields
#
#  id              :uuid             not null, primary key
#  field_type      :string           not null
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  content_type_id :uuid             not null
#
class Field < ApplicationRecord
end
