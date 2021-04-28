# require 'rails_helper'
#
# RSpec.describe RoadTripFacade do
#   describe 'happy path' do
#     it 'can get the road trip with valid parameters' do
#       VCR.use_cassette('road_trip_data') do
#         user = User.create(email: 'whatever@example.com', password: 'password', password_confirmation: 'password')
#         route = {
#           origin: 'chicago,il',
#           destination: 'denver,co',
#           api_key: user.api_key
#         }
#
#         result = RoadTripFacade.create_new_road_trip(route)
#
#         expect(result).to be_a(RoadTrip)
#         expect(result.id).to be(nil)
#         expect(result.start_city).to eq(route[:origin])
#         expect(result.end_city).to eq(route[:destination])
#         expect(result.travel_time).to be_a(String)
#         expect(result.weather_at_eta).to be_a(hash)
#       end
#     end
#   end
# end
