class Api::V1::StudentController < Api::V1::ApiController
  def index
    render json: assigned_homeworks,
           each_serializer: ::Api::V1::Student::HomeworkIndexSerializer,
           #  assigned_homework:,
           meta: meta(assigned_homeworks),
           adapter: :json
  end

  private

  def assigned_homeworks
    @assigned_homeworks ||= current_user.assigned_homeworks.includes(homework: [:subject]).page(page).per(per)
  end
end
