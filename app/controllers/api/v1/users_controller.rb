class Api::V1::UsersController < Api::V1::ApiController
  def sync
    if current_user
      render json: current_user,
             status: :ok,
             # TODO: change this to homework details serializer
             serializer: ::Api::V1::UserSerializer
    else
      record_not_found
    end
  end
end
