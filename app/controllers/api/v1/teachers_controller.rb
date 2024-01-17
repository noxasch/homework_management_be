class Api::V1::TeachersController < Api::V1::ApiController
  before_action :authorize_user

  private

  def authorize_user
    return true if current_user.teacher?

    render json: { errors: { unathorized: 'User are not authorized to access this resources!' } }, status: :unauthorized
  end
end
