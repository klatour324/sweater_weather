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
      describe 'get route' do
          it 'fetches a route for a trip with a given origin and destination for locations' do
            VCR.use_cassette('road_trip_route') do
            start = 'chicago,il'
            destination = 'denver,co'

            result = MapquestService.get_directions(start, destination)

            expect(result).to be_a(Hash)
            expect(result).to have_key(:route)
            expect(result[:route]).to be_a(Hash)
            expect(result[:route]).to have_key(:boundingBox)
            expect(result[:route][:boundingBox]).to be_a(Hash)
            expect(result[:route][:boundingBox]).to have_key(:lr)
            expect(result[:route][:boundingBox][:lr]).to be_a(Hash)
            expect(result[:route][:boundingBox][:lr]).to have_key(:lng)
            expect(result[:route][:boundingBox][:lr][:lng]).to be_a(Float)
            expect(result[:route][:boundingBox][:lr]).to have_key(:lat)
            expect(result[:route][:boundingBox][:lr][:lat]).to be_a(Float)
            expect(result[:route][:boundingBox]).to have_key(:ul)
            expect(result[:route][:boundingBox][:ul]).to be_a(Hash)
            expect(result[:route][:boundingBox][:ul]).to have_key(:lng)
            expect(result[:route][:boundingBox][:ul][:lng]).to be_a(Float)
            expect(result[:route][:boundingBox][:ul]).to have_key(:lat)
            expect(result[:route][:boundingBox][:ul][:lat]).to be_a(Float)
            expect(result[:route]).to have_key(:distance)
            expect(result[:route][:distance]).to be_a(Float)
            expect(result[:route]).to have_key(:formattedTime)
            expect(result[:route][:formattedTime]).to be_a(String)
            expect(result[:route]).to have_key(:realTime)
            expect(result[:route][:realTime]).to be_an(Integer)
          end
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

      it 'returns a response error if the origin(start) is empty' do
        VCR.use_cassette('mapquest_service_no_origin') do
          start = ''
          destination = 'denver,co'
          result = MapquestService.get_directions(start, destination)

          expect(result).to be_a(Hash)
          expect(result).to have_key(:info)
          expect(result[:info]).to be_a(Hash)
          expect(result[:info]).to have_key(:statuscode)
          expect(result[:info][:statuscode]).to eq(611)
          expect(result[:info]).to have_key(:messages)
          expect(result[:info][:messages]).to be_an(Array)
          expect(result[:info][:messages].first).to eq("At least two locations must be provided.")
        end
      end

      it 'returns a response error if the destination is empty' do
        VCR.use_cassette('mapquest_service_no_destination') do
          start = 'chicago,il'
          destination = ''
          result = MapquestService.get_directions(start, destination)

          expect(result).to be_a(Hash)
          expect(result).to have_key(:info)
          expect(result[:info]).to be_a(Hash)
          expect(result[:info]).to have_key(:statuscode)
          expect(result[:info][:statuscode]).to eq(611)
          expect(result[:info]).to have_key(:messages)
          expect(result[:info][:messages]).to be_an(Array)
          expect(result[:info][:messages].first).to eq("At least two locations must be provided.")
        end
      end

      it 'returns an error if destination is impossible to make' do
        VCR.use_cassette('maquest_impossible_destination') do
          start = 'chicago,il'
          destination = 'paris,fr'
          result = MapquestService.get_directions(start, destination)

          expect(result).to be_a(Hash)
          expect(result).to have_key(:info)
          expect(result[:info]).to have_key(:statuscode)
          expect(result[:info][:statuscode]).to eq(402)
          expect(result[:info]).to have_key(:messages)
          expect(result[:info][:messages].first).to eq("We are unable to route with the given locations.")
        end
      end
    end
  end
end
