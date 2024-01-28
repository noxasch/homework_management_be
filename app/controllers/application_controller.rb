class ApplicationController < ActionController::API
  private

  def current_user
    return unless doorkeeper_token
    return @current_user if @current_user

    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
    @current_user
  end

  def success
    render json: { success: true }, status: :ok
  end

  def record_not_found
    render json: { errors: { not_found: 'Record cannot be found' } }, status: :not_found
  end

  def per
    params[:per].to_i.positive? ? params[:per].to_i : Kaminari.config.default_per_page
  end

  def page
    params[:page].to_i.positive? ? params[:page].to_i : 1
  end

  def meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }
  end
end
