require 'rails_helper'

RSpec.describe Forecast do
  describe 'happy path' do
    it 'should build a Forecast PORO that combines current, daily and hourly forecasts' do
      VCR.use_cassette('get_forecast_poro_data') do
        location = 'denver,co'
        map_data = MapquestService.find_location(location)[:results].first
        coordinates = Coordinate.new(map_data)
        weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
        forecast = Forecast.new(weather)

        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather).to be_a(CurrentWeather)
        expect(forecast.daily_weather.first).to be_a(DailyWeather)
        expect(forecast.hourly_weather.first).to be_a(HourlyWeather)
      end
    end
  end
end
