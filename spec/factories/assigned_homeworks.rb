# == Schema Information
#
# Table name: assigned_homeworks
#
#  id                :bigint           not null, primary key
#  invited_at        :datetime
#  status            :integer          default("newly_added")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  homework_id       :bigint           not null
#  student_id        :bigint           not null
#  submitted_file_id :string
#
# Indexes
#
#  index_assigned_homeworks_on_homework_id                 (homework_id)
#  index_assigned_homeworks_on_homework_id_and_student_id  (homework_id,student_id) UNIQUE
#  index_assigned_homeworks_on_student_id                  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (homework_id => homeworks.id)
#  fk_rails_...  (student_id => users.id)
#
FactoryBot.define do
  factory :assigned_homework do
  end
end
