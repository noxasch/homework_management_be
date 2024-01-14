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
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating teacher should be valid' do
    subject(:user) do
      described_class.create(
        name: 'David Tenant',
        email: 'davidtenant@example.com',
        password: 'password',
        role: :teacher
      )
    end

    it 'attribute should be valid' do
      expect(user).to be_valid
      expect(user.teacher?).to be(true)
      expect(user.student?).to be(false)
    end
  end
end
