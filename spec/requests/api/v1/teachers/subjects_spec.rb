require 'rails_helper'

RSpec.describe 'Api::V1::Teachers::Subjects', type: :request do
  let(:teacher) do
    create(:user, role: :teacher, name: 'Teacher 1', email: 'teacher@gmail.com', password: 'password')
  end
  let(:maths) do
    create(:subject, color: '#ff3333', name: 'Mathematics')
  end
  let(:history) do
    create(:subject, color: '#ff3333', name: 'History')
  end
  let(:token) { create(:access_token, resource_owner_id: teacher.id, scopes: 'api') }

  before do
    host! 'www.example.com'
  end

  describe 'GET /index' do
    before do
      maths && history
    end

    it do
      get '/api/v1/teachers/subjects', params: {}, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['subjects'].length).to eq(2)
    end
  end
end
