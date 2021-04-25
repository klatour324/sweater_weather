class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def error(message = "Invalid request error. Please check the request")
    render json: { error: message }, status: :bad_request
  end
end
