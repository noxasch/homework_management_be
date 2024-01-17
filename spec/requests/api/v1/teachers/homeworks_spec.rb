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
  let(:homework2) do
    create(:homework, title: 'Algebra', due_at: Time.current, teacher:, subject: maths)
  end
  let(:application) { create(:application) }
  let(:token) { create(:access_token, application:, resource_owner_id: teacher.id) }

  before do
    host! 'www.example.com'
    # token
  end

  describe 'GET /index' do
    before do
      homework && homework2
    end

    it do
      get '/api/v1/teachers/homeworks', params: {}, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['homeworks'].length).to eq(2)
    end

    context 'when search' do
      it do
        get '/api/v1/teachers/homeworks', params: { query: 'Cal' }, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['homeworks'].length).to eq(1)
      end
    end
  end

  describe 'GET /show' do
    before do
      homework
    end

    it do
      get "/api/v1/teachers/homeworks/#{homework.id}", params: {}, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:ok)
    end

    context 'when invalid id' do
      it do
        get '/api/v1/teachers/homeworks/123123', params: {}, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when student try to access' do
      let(:student) do
        create(:user, role: :student, name: 'Student 1', email: 'student@gmail.com', password: 'password')
      end
      let(:application) { create(:application) }
      let(:token) { create(:access_token, application:, resource_owner_id: student.id) }

      it do
        get '/api/v1/teachers/homeworks/123123', params: {}, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    let(:params) do
      {
        homework: {
          title: 'Test homework',
          due_at: '2024-01-17',
          subject_id: maths.id
        }
      }
    end

    before do
      homework
    end

    it do
      post '/api/v1/teachers/homeworks', params:, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:created)
      expect(response.parsed_body).to include_json({
        title: params[:homework][:title],
        subject: maths.name,
        due_date: '17-01-2024',
        submitted: 0,
        total: 0
      })
    end
  end
end
