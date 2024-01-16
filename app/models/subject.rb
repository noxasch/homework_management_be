# == Schema Information
#
# Table name: subjects
#
#  id         :bigint           not null, primary key
#  color      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subject < ApplicationRecord
  validates :color, length: { minimum: 7, maximum: 7 }, format: { with: /\A#(?:[0-9a-fA-F]{3}){1,2}\z/ }
end
