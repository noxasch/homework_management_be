# == Schema Information
#
# Table name: invites
#
#  id         :bigint           not null, primary key
#  expires_in :integer          not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_invites_on_student_id  (student_id)
#  index_invites_on_token       (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#
class Invite < ApplicationRecord
  belongs_to :student, class_name: 'User'

  def expired?
    Time.current.after?(created_at + expires_in.seconds)
  end
end
