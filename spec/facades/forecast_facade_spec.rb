require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'happy path' do
    it 'can get the forecast for a city and state search' do
      location = 'Denver, CO'
      forecast = ForecastFacade.get_forecast(location)


      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(CurrentWeather)
      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather.count).to eq(5)
      expect(forecast.daily_weather.first).to be_a(DailyWeather)
      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather.count).to eq(8)
      expect(forecast.hourly_weather.first).to be_a(HourlyWeather)
    end
  end
end
