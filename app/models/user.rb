# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string
#  role            :string           default("student"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, email: true

  # rubocop:disable Rails/InverseOf
  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all
  # rubocop:enable Rails/InverseOf

  has_many :homeworks, dependent: :destroy, inverse_of: :teacher
  has_many :assigned_homeworks, dependent: :destroy, inverse_of: :student

  enum role: {
    student: 'student',
    teacher: 'teacher'
  }
end
