# == Schema Information
#
# Table name: student_homeworks
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
#  index_student_homeworks_on_homework_id                 (homework_id)
#  index_student_homeworks_on_homework_id_and_student_id  (homework_id,student_id) UNIQUE
#  index_student_homeworks_on_student_id                  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (homework_id => homeworks.id)
#  fk_rails_...  (student_id => users.id)
#
class StudentHomework < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :homework

  enum status: {
    newly_added: 0,
    invited: 1,
    pending_submission: 2,
    completed: 3
  }
end
