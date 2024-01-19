class Api::V1::Teachers::SubjectsController < Api::V1::ApiController
  def index
    render json: subjects,
           each_serializer: ::Api::V1::Teacher::SubjectIndexSerializer,
           adapter: :json
  end

  private

  def subjects
    @subjects ||= Subject.all
  end
end
