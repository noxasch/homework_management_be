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
FactoryBot.define do
  factory :subject do
    sequence(:name) do |n|
      "#{n.ordinalize} Quote"
    end
    color { '#6495ed' }
  end
end
