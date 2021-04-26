class Api::V1::SessionsController < ApplicationController
  def create
    if !valid_params.all? { |key| params.has_key?(key) }
      error = "Password or email is incorrect."
      error(error)
    elsif
      user = User.find_by(email: params[:email].downcase)
      if user && user.authenticate(params[:password])
        render json: UsersSerializer.new(user)
      else
        error(new_user.errors.full_messages.to_sentence)
      end
    end
  end

  private

  def valid_params
    [:email, :password]
  end
end
