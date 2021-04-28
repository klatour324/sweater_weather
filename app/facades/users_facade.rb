# class UsersFacade
#   def self.create_new_user(params)
#     return 'invalid credentials' if !valid_params.all? { |key| params.has_key?(key) }
#     User.create(user_params(params))
#   end
#
#   private
#
#   def self.valid_params
#     [:email, :password, :password_confirmation]
#   end
#
#   def self.user_params(params)
#     params[:email] = params[:email].downcase
#     params.permit(:email, :password, :password_confirmation)
#   end
# end
