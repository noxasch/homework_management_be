class Api::V1::ApiController < ApplicationController
  before_action :doorkeeper_authorize_api

  def doorkeeper_authorize_api
    doorkeeper_authorize! :api
  end
end
