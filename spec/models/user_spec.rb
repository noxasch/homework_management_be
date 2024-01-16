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

  context 'when defined relationship' do
    let(:teacher) do
      create(:user, role: :teacher, name: 'Teacher 1', email: 'teacher@gmail.com', password: 'password')
    end
    let(:maths) do
      create(:subject, color: '#ff3333', name: 'Mathematics')
    end
    let(:homework) do
      create(:homework, title: 'Calculus', due_at: Time.current, teacher:, subject: maths)
    end

    before do
      homework
    end

    it 'refer to the correct object' do
      expect(teacher.homeworks.first).to eq(homework)
      expect(teacher.homeworks.first.teacher).to eq(teacher)
    end
  end
end
