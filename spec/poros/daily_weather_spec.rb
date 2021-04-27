require 'rails_helper'

RSpec.describe DailyWeather do
  describe 'happy path' do
    it 'should build a Daily Weather PORO based on input' do
      VCR.use_cassette('get_current_weather_data') do
        location = 'denver,co'
        map_data = MapquestService.find_location(location)[:results].first
        coordinates = Coordinate.new(map_data)
        weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
        daily_weather = DailyWeather.new(weather[:daily].first)

        expect(daily_weather).to be_a(DailyWeather)
        expect(daily_weather.date).to be_a(String)
        expect(daily_weather.date).to eq(Time.at(weather[:daily].first[:dt]).strftime("%Y-%m-%d"))
        expect(daily_weather.sunrise).to be_a(String)
        expect(daily_weather.sunrise).to eq(Time.at(weather[:daily].first[:sunrise]).to_s)
        expect(daily_weather.sunset).to be_a(String)
        expect(daily_weather.sunset).to eq(Time.at(weather[:daily].first[:sunset]).to_s)
        expect(daily_weather.min_temp).to be_a(Float)
        expect(daily_weather.max_temp).to be_a(Float)
        expect(daily_weather.conditions).to be_a(String)
        expect(daily_weather.icon).to be_a(String)
      end
    end
  end
end
