class Api::V1::Teachers::HomeworksController < Api::V1::TeachersController
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
             # TODO: change this to homework details serializer
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
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

  def update
    outcome = Api::V1::Teachers::Homeworks::Create.run(create_params)

    if outcome.success?
      render json: outcome.result,
             status: :accepted,
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializerSerializer
    else
      # map error into hash
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

  def destroy
    outcome = Api::V1::Teachers::Homeworks::Create.run(destroy_params)

    if outcome.success?
      render json: { success: true }, status: :accepted
    else
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

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

  def destroy_params
    {
      id: params[:id],
      current_user:
    }
  end

  def update_params
    {
      **base_params,
      current_user:
    }.compact
  end

  def create_params
    {
      **base_params,
      current_user:
    }.compact
  end

  def base_params
    params.permit(:title, :due_at, :subject_id)
  end
end
