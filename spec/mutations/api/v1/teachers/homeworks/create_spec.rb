require 'rails_helper'

describe Api::V1::Teachers::Homeworks::Create, type: :mutation do
  subject(:outcome) { described_class.run(inputs) }

  let(:teacher) do
    create(:user, role: :teacher, name: 'Teacher 1', email: 'teacher@gmail.com', password: 'password')
  end
  let(:maths) do
    create(:subject, color: '#ff3333', name: 'Mathematics')
  end
  let(:inputs) do
    {
      title: 'Calculus',
      current_user: teacher,
      subject: maths,
      due_at: '2024-01-16 +08'
    }
  end

  describe 'execute' do
    it do
      expect(outcome.success?).to be(true)
      expect(outcome.result.attributes).to include({
        title: 'Calculus',
        teacher_id: teacher.id,
        subject_id: maths.id,
        due_at: Time.zone.parse('2024-01-16')
      }.deep_stringify_keys)
    end
  end
end
