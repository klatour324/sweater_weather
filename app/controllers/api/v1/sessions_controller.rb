class Api::V1::SessionsController < ApplicationController
  def create
    error = "Password or email is incorrect."
    return error(error) if !valid_params.all? { |key| params.has_key?(key) }
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
    # user = SessionsFacade.get_authenticated_user(params)
    # if user == 'invalid parameters'
    # elsif user
      render json: UsersSerializer.new(user)
    else
      error(error)
    end
  end

  private

  def valid_params
    [:email, :password]
  end
end
