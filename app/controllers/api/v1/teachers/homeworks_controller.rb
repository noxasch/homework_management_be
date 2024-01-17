class Api::V1::Teachers::HomeworksController < ApplicationController
  def index
    render json: homeworks,
           each_serializer: ::Api::V1::Teacher::HomeworkIndexSerializerSerializer,
           meta: meta(homeworks),
           adapter: :json
  end

  def show
    if homework
      render json: homework,
             status: :ok,
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializerSerializer
    else
      record_not_found
    end
  end

  def create
    outcome = Api::V1::Teachers::Homeworks::Create.run(create_params)

    if outcome.success?
      render json: outcome.result,
             status: :created,
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializerSerializer
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def update; end
  def destroy; end

  private

  def homework
    @homework ||= current_user.homeworks.find_by(id: params[:id])
  end

  def homeworks
    @homeworks ||= current_user.homeworks.search(search_params).page(page).per(per)
  end

  def search_params
    {
      q: params[:query]
    }
  end

  def create_params
    params.require(:homework).permit(:title, :due_at, :subject_id)
  end
end
