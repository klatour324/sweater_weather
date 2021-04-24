require 'rails_helper'

RSpec.describe MapquestService do
  describe 'happy path' do
    describe 'fetch data' do
      it 'returns the latitude and longitude data for a given location' do
        VCR.use_cassette('location_coordinate_data') do
          location = 'Denver, CO'
          data = MapquestService.find_location(location)

          expect(data).to be_a(Hash)
          expect(data).to have_key(:results)
          expect(data[:results]).to be_an(Array)
          expect(data[:results].first).to have_key(:locations)
          expect(data[:results].first[:locations]).to be_an(Array)
          expect(data[:results].first[:locations].first).to have_key(:latLng)
          expect(data[:results].first[:locations].first[:latLng]).to be_a(Hash)
          expect(data[:results].first[:locations].first[:latLng]).to have_key(:lat)
          expect(data[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
          expect(data[:results].first[:locations].first[:latLng]).to have_key(:lng)
          expect(data[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
        end
      end
    end

    describe 'sad path' do
      it 'returns a 400 error response if the location does not exist' do
        VCR.use_cassette('mapquest_service_no_location') do
          location = ''
          response = MapquestService.find_location(location)

          expect(response).to be_a(Hash)
          expect(response).to have_key(:info)
          expect(response[:info]).to have_key(:statuscode)
          expect(response[:info][:statuscode]).to eq(400)
          expect(response[:info]).to have_key(:messages)
          expect(response[:info][:messages]).to eq(["Illegal argument from request: Insufficient info for location"])
        end
      end
    end
  end
end
