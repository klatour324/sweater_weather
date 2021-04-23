require 'rails_helper'

RSpec.describe MapquestService do
  describe 'happy path' do
    describe 'fetch data'
    it 'returns the latitude and longitude data for a given location' do
      location = 'Denver, CO'
      data = MapquestService.location(location)

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
