class Api::V1::Teachers::HomeworksController < ApplicationController
  def index
    render json: homeworks,
           each_serializer: ::Api::V1::Teacher::HomeworkIndexSerializerSerializer,
           meta: meta(homeworks),
           adapter: :json
  end

  def show; end
  def create; end
  def update; end
  def destroy; end

  private

  def homeworks
    @homeworks ||= current_user.homeworks.page(page).per(per)
  end
end
