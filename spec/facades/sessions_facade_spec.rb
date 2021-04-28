# require 'rails_helper'
#
# RSpec.describe SessionsFacade do
#   describe ' happy path' do
#     it 'can get the User for a given session with valid parameters' do
#       user = User.create!(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')
#       params = {email: user.email, password: 'password'}
#
#       result = SessionsFacade.get_authenticated_user(params)
#
#       expect(result).to be_a(User)
#       expect(result).to eq(user)
#     end
#   end
# end
