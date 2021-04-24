require 'rails_helper'

RSpec.describe HourlyWeather do
  describe 'happy path' do
    it 'should build an Hourly Weather PORO based on input' do
      VCR.use_cassette('get_current_weather_data') do
        location = 'denver,co'
        map_data = MapquestService.find_location(location)[:results].first
        coordinates = Coordinate.new(map_data)
        weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.long)
        hourly_weather = HourlyWeather.new(weather[:hourly])

        expect(hourly_weather).to be_a(HourlyWeather)
        expect(hourly_weather.time).to be_a(String)
        expect(hourly_weather.time).to eq(Time.at(weather[:hourly].first[:dt]).strftime("%H:%M:%S"))
        expect(hourly_weather.temperature).to be_a(Float)
        expect(hourly_weather.conditions).to be_a(String)
        expect(hourly_weather.icon).to be_a(String)
      end
    end
  end
end
