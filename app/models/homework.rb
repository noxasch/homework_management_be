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
#  subject_id       :bigint           not null
#  teacher_id       :bigint           not null
#
# Indexes
#
#  index_homeworks_on_subject_id  (subject_id)
#  index_homeworks_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
class Homework < ApplicationRecord
  belongs_to :teacher, -> { where(role: :teacher) }, class_name: 'User', inverse_of: :homeworks
  belongs_to :subject

  has_many :student_homeworks, dependent: :destroy

  def self.search(args = {})
    return all if args.blank?

    res = all
    res = res.where('homeworks.title ILIKE :query', query: "%#{args[:q].downcase}%") if args[:q].present?
    res
  end
end
