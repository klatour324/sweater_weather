require 'rails_helper'

RSpec.describe Coordinate do
  describe 'happy path' do
    it 'should build a Coordinate PORO based on input' do
      VCR.use_cassette('get_mapquest_coordinates') do
        location = 'denver,co'
        map_data = MapquestService.find_location(location)[:results].first
        coordinates = Coordinate.new(map_data)

        expect(coordinates).to be_a(Coordinate)
        expect(coordinates.lat).to be_a(Float)
        expect(coordinates.lng).to be_a(Float)
      end
    end
  end
end
