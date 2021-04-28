class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :unauthorized
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def error(message = "Invalid request error. Please check the request")
    render json: { error: message }, status: :bad_request
  end

  def invalid_record(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unauthorized(exception)
    render json: { error: exception.message }, status: :unauthorized
  end
end
