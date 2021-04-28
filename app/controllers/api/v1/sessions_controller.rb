class Api::V1::SessionsController < ApplicationController
  def create
    user = SessionsFacade.get_authenticated_user(valid_params)
    if user == 'invalid parameters'
      error = "Password or email is incorrect."
      return error(error)
    elsif user
      render json: UsersSerializer.new(user)
    else
      error(error)
    end
  end
end
