class Api::V1::UsersController < ApplicationController

  def create
    if !valid_params.all? { |key| params.has_key?(key) }
      error = "Invalid request. Please try again."
      error(error)
    elsif
      new_user = User.create!(user_params)
      render json: UsersSerializer.new(new_user), status: :created
    #   new_user = User.new(user_params)
    #   if new_user.save
    #     render json: UsersSerializer.new(new_user), status: :created
    else
      error(new_user.errors.full_messages.to_sentence)
    end
  end

  private

  def valid_params
    [:email, :password, :password_confirmation]
  end

  def user_params
    params[:email] = params[:email].downcase
    params.permit(:email, :password, :password_confirmation)
  end
end
