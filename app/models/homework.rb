# == Schema Information
#
# Table name: homeworks
#
#  id               :bigint           not null, primary key
#  due_at           :datetime         not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  resource_file_id :string
#  teacher_id       :bigint           not null
#
# Indexes
#
#  index_homeworks_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
class Homework < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
end
