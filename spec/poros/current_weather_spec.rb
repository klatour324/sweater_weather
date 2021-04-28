require 'rails_helper'

RSpec.describe CurrentWeather do
  describe 'happy path' do
    it 'should build a Current Weather PORO based on input' do
      VCR.use_cassette('get_current_weather_data') do
        location = 'denver,co'
        map_data = MapquestService.find_location(location)[:results].first
        coordinates = Coordinate.new(map_data)
        weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
        current_weather = CurrentWeather.new(weather[:current])

        expect(current_weather).to be_a(CurrentWeather)
        expect(current_weather.datetime).to be_a(String)
        expect(current_weather.datetime).to eq(Time.at(weather[:current][:dt]).to_s)
        expect(current_weather.sunrise).to be_a(String)
        expect(current_weather.sunrise).to eq(Time.at(weather[:current][:sunrise]).to_s)
        expect(current_weather.sunset).to be_a(String)
        expect(current_weather.sunset).to eq(Time.at(weather[:current][:sunset]).to_s)
        expect(current_weather.temperature).to be_a(Float)
        expect(current_weather.feels_like).to be_a(Float)
        expect(current_weather.humidity).to be_an(Integer).or be_a(Float)
        expect(current_weather.uvi).to be_an(Integer).or be_a(Float)
        expect(current_weather.visibility).to be_an(Integer).or be_a(Float)
        expect(current_weather.conditions).to be_a(String)
        expect(current_weather.icon).to be_a(String)
      end
    end
  end
end
