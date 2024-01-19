class Api::V1::Teachers::HomeworksController < Api::V1::TeachersController
  def index
    render json: homeworks,
           each_serializer: ::Api::V1::Teacher::HomeworkIndexSerializer,
           meta: meta(homeworks),
           adapter: :json
  end

  def show
    if homework
      render json: homework,
             status: :ok,
             # TODO: change this to homework details serializer
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializer
    else
      record_not_found
    end
  end

  def create
    outcome = Api::V1::Teachers::Homeworks::Create.run(create_params)

    if outcome.success?
      render json: outcome.result,
             status: :created,
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializer
    else
      render json: { errors: outcome.errors }, status: :unprocessable_entity
    end
  end

  def update
    outcome = Api::V1::Teachers::Homeworks::Update.run(update_params)

    if outcome.success?
      render json: outcome.result,
             status: :accepted,
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializer
    else
      # map outcome error into hash
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

  def destroy
    outcome = Api::V1::Teachers::Homeworks::Destroy.run(destroy_params)

    if outcome.success?
      render json: { success: true }, status: :accepted
    else
      # map outcome error into hash
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

  def assign
    outcome = Api::V1::Teachers::Homeworks::Assign.run(assign_params)

    if outcome.success?
      render json: outcome.result,
             status: :accepted,
             serializer: ::Api::V1::Teacher::HomeworkIndexSerializer
    else
      # map outcome error into hash
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

  def unassign
    outcome = Api::V1::Teachers::Homeworks::Unassign.run(assign_params)

    if outcome.success?
      render json: { success: true }, status: :accepted
    else
      # map outcome error into hash
      render json: { errors: {} }, status: :unprocessable_entity
    end
  end

  private

  def homework
    @homework ||= current_user.homeworks.find_by(id: params[:id])
  end

  def homeworks
    @homeworks ||= current_user
                   .homeworks
                   .search(search_params)
                   .sorted_by(sorted_by_params)
                   .page(page).per(per)
  end

  def search_params
    {
      subject_ids: params[:subject_ids],
      query: params[:query]
    }.compact
  end

  def create_params
    {
      **base_params,
      current_user:
    }.compact
  end

  def update_params
    {
      **base_params,
      current_user:
    }.compact
  end

  def destroy_params
    {
      id: params[:id],
      current_user:
    }
  end

  def assign_params
    {
      id: params[:id],
      student_id: params[:student_id],
      current_user:
    }.compact
  end

  def base_params
    params.permit(:id, :title, :due_at, :subject_id)
  end

  def sorted_by_params
    params[:sorted_by]
  end
end
