class Api::V1::TeachersController < ApplicationController
  before_action :authorize_user

  private

  def authorize_user
    return true if current_user.teacher?

    render json: { errors: { unathorized: 'User are not authorized to access this resources!' } }, status: :unauthorized
  end
end
