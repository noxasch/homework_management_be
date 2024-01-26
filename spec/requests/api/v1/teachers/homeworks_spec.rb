require 'rails_helper'

RSpec.describe 'Api::V1::Teachers::Homeworks', type: :request do
  let(:teacher) do
    create(:user, role: :teacher, name: 'Teacher 1', email: 'teacher@gmail.com', password: 'password')
  end
  let(:maths) do
    create(:subject, color: '#ff3333', name: 'Mathematics')
  end
  let(:history) do
    create(:subject, color: '#ff3333', name: 'History')
  end
  let(:homework) do
    create(:homework, title: 'Calculus', due_at: Time.zone.parse('2024-01-14'), teacher:, subject: maths)
  end
  let(:homework2) do
    create(:homework, title: 'Algeria', due_at: Time.zone.parse('2024-01-15'), teacher:, subject: history)
  end
  let(:token) { create(:access_token, resource_owner_id: teacher.id, scopes: 'api') }

  before do
    host! 'www.example.com'
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

    context 'when filter by subject' do
      it do
        get '/api/v1/teachers/homeworks', params: { subject_ids: [maths.id] },
                                          headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['homeworks'].length).to eq(1)
      end
    end

    context 'when sorted_by' do
      it do
        get '/api/v1/teachers/homeworks', params: { sorted_by: 'subject' },
                                          headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['homeworks'].length).to eq(2)
        expect(response.parsed_body['homeworks'].pluck('id')).to eq([
          homework2.id, homework.id
        ])
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
      let(:token) { create(:access_token, resource_owner_id: student.id, scopes: 'api') }

      it do
        get '/api/v1/teachers/homeworks/123123', params: {}, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    let(:params) do
      {
        title: 'Test homework',
        due_at: '2024-01-17',
        subject_id: maths.id
      }
    end

    before do
      teacher && maths
    end

    it do
      post '/api/v1/teachers/homeworks', params:, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:created)
      expect(response.parsed_body).to include_json({
        title: params[:title],
        subject: maths.name,
        due_date: '17-01-2024',
        submitted: 0,
        total: 0
      })
    end
  end

  describe 'PUT /update' do
    let(:history) do
      create(:subject, color: '#4ca64c', name: 'History')
    end
    let(:params) do
      {
        title: 'Updated title',
        due_at: '2024-01-17',
        subject_id: history.id
      }
    end

    before do
      homework
    end

    it do
      put "/api/v1/teachers/homeworks/#{homework.id}", params:, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:accepted)
      expect(response.parsed_body).to include_json({
        title: 'Updated title',
        subject: 'History',
        due_date: '17-01-2024',
        submitted: 0,
        total: 0
      })
    end
  end

  describe 'DELETE /destroy' do
    let(:params) do
      {
        id: homework.id
      }
    end

    before do
      homework
    end

    it do
      delete "/api/v1/teachers/homeworks/#{homework.id}", params:, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:accepted)
    end
  end

  describe 'POST /assign' do
    let(:student) do
      create(:user, role: :student, name: 'Student 1', email: 'student@gmail.com', password: 'password')
    end

    let(:params) do
      {
        student_id: student.id
      }
    end

    before do
      homework
    end

    it do
      post "/api/v1/teachers/homeworks/#{homework.id}/assign", params:, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:accepted)
      expect(response.parsed_body).to include_json({
        title: 'Calculus',
        subject: maths.name,
        due_date: '14-01-2024',
        submitted: 0,
        total: 1
      })
    end
  end

  describe 'DELETE /unassign' do
    let(:student) do
      create(:user, role: :student, name: 'Student 1', email: 'student@gmail.com', password: 'password')
    end
    let(:assigned_homework) do
      create(:assigned_homework, homework:, student:)
    end

    let(:params) do
      {
        student_id: student.id
      }
    end

    before do
      assigned_homework
    end

    it do
      post "/api/v1/teachers/homeworks/#{homework.id}/unassign",
           params:, headers: { Authorization: "Bearer #{token.token}" }
      expect(response).to have_http_status(:accepted)
    end
  end
end
