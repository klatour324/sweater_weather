class ApplicationController < ActionController::API

  def error(message = "Invalid request error. Please check the request")
    render json: { error: message }, status: :bad_request
  end
end
