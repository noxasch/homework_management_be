require 'rails_helper'

RSpec.describe 'Api::V1::Teachers::Homeworks', type: :request do
  let(:teacher) do
    create(:user, role: :teacher, name: 'Teacher 1', email: 'teacher@gmail.com', password: 'password')
  end
  let(:maths) do
    create(:subject, color: '#ff3333', name: 'Mathematics')
  end
  let(:homework) do
    create(:homework, title: 'Calculus', due_at: Time.current, teacher:, subject: maths)
  end
  let(:application) { create(:application) }
  let(:token) { create(:access_token, application:, resource_owner_id: teacher.id) }

  before do
    host! 'www.example.com'
    # token
  end

  describe 'GET /index' do
    before do
      homework
    end

    it do
      get '/api/v1/teachers/homeworks', params: {}, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:ok)
    end
  end
end
