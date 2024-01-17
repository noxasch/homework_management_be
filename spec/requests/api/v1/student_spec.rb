require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  let(:teacher) do
    create(:user, role: :teacher, name: 'Teacher 1', email: 'teacher@gmail.com', password: 'password')
  end
  let(:student) do
    create(:user, role: :student, name: 'Student 1', email: 'student@gmail.com', password: 'password')
  end
  let(:maths) do
    create(:subject, color: '#ff3333', name: 'Mathematics')
  end
  let(:homework) do
    create(:homework, title: 'Calculus', due_at: Time.zone.parse('2024-01-14'), teacher:, subject: maths)
  end
  let(:homework2) do
    create(:homework, title: 'Algebra', due_at: Time.zone.parse('2024-01-15'), teacher:, subject: maths)
  end
  let(:assigned_homework) do
    create(:assigned_homework, homework:, student:)
  end
  let(:assigned_homework2) do
    create(:assigned_homework, homework: homework2, student:)
  end
  let(:application) { create(:application) }
  let(:token) { create(:access_token, resource_owner_id: student.id, scopes: 'api') }

  before do
    host! 'www.example.com'
  end

  describe 'GET /index' do
    before do
      assigned_homework && assigned_homework2
    end

    it do
      get '/api/v1/student', params: {}, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['assigned_homeworks'].length).to eq(2)
    end
  end
end
