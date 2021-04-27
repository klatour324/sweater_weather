require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'happy path' do
    it 'creates a roadtrip PORO based on input' do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'
      data = MapquestService.get_directions(origin, destination)
      forecast = ForecastFacade.get_forecast(destination)

      road_trip = RoadTrip.new(origin, destination, data, forecast)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.start_city).to be_a(String)
      expect(road_trip.end_city).to be_a(String)
      expect(road_trip.travel_time).to be_a(String)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
