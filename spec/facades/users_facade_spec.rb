# require 'rails_helper'
#
# RSpec.describe UsersFacade do
#   describe 'happy path' do
#     it 'can get the user with valid parameters' do
#       params = ActionController::Parameters.new({email: 'whatever@example.com', password: 'password', password_confirmation: 'password'})
#       result = UsersFacade.create_new_user(params)
#       user = User.last
#
#       expect(result).to be_a(User)
#       expect(result).to eq(user)
#       expect(user.email).to eq(params[:email])
#       expect(user.password_digest).to_not be_nil
#       expect(user.api_key.length).to eq(28)
#     end
#   end
# end
