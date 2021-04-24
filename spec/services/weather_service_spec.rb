require 'rails_helper'

RSpec.describe WeatherService do
  describe 'happy path' do
    describe 'fetch data' do
      it 'returns the current forecast data for a given location based on longitude and latitude' do
        VCR.use_cassette('current_weather_data') do
          location = 'Denver, CO'
          mapquest_data = MapquestService.find_location(location)
          latitude = mapquest_data[:results].first[:locations].first[:latLng][:lat]
          longitude = mapquest_data[:results].first[:locations].first[:latLng][:lng]

          data = WeatherService.find_forecast_for_location(latitude, longitude)

          expect(data).to be_a(Hash)
          expect(data).to have_key(:lat)
          expect(data[:lat]).to be_a(Float)
          expect(data).to have_key(:lon)
          expect(data[:lon]).to be_a(Float)
          expect(data).to have_key(:current)
          expect(data[:current]).to be_a(Hash)
          expect(data[:current]).to have_key(:dt)
          expect(data[:current][:dt]).to be_an(Integer)
          expect(data[:current]).to have_key(:sunrise)
          expect(data[:current][:sunrise]).to be_an(Integer)
          expect(data[:current]).to have_key(:sunset)
          expect(data[:current][:sunset]).to be_an(Integer)
          expect(data[:current]).to have_key(:temp)
          expect(data[:current][:temp]).to be_a(Float)
          expect(data[:current]).to have_key(:feels_like)
          expect(data[:current][:feels_like]).to be_a(Float)
          expect(data[:current]).to have_key(:humidity)
          expect(data[:current][:humidity]).to be_an(Integer)
          expect(data[:current]).to have_key(:uvi)
          expect(data[:current][:uvi]).to be_an(Integer).or(be_a Float)
          expect(data[:current]).to have_key(:visibility)
          expect(data[:current][:visibility]).to be_an(Integer)
          expect(data[:current]).to have_key(:weather)
          expect(data[:current][:weather].first).to be_a(Hash)
          expect(data[:current][:weather].first).to have_key(:description)
          expect(data[:current][:weather].first[:description]).to be_a(String)
          expect(data[:current][:weather].first).to have_key(:icon)
          expect(data[:current][:weather].first[:icon]).to be_a(String)
        end
      end

      it 'returns the daily forecast data for a given location based on longitude and latitude' do
        VCR.use_cassette('daily_forecast_data') do
          location = 'Denver, CO'
          mapquest_data = MapquestService.find_location(location)
          latitude = mapquest_data[:results].first[:locations].first[:latLng][:lat]
          longitude = mapquest_data[:results].first[:locations].first[:latLng][:lng]

          data = WeatherService.find_forecast_for_location(latitude, longitude)

          expect(data).to be_a(Hash)
          expect(data).to have_key(:daily)
          expect(data[:daily].count).to eq(8)
          expect(data[:daily].first).to be_a(Hash)
          expect(data[:daily].first).to have_key(:dt)
          expect(data[:daily].first[:dt]).to be_an(Integer)
          expect(data[:daily].first).to have_key(:sunrise)
          expect(data[:daily].first[:sunrise]).to be_an(Integer)
          expect(data[:daily].first).to have_key(:sunset)
          expect(data[:daily].first[:sunset]).to be_an(Integer)
          expect(data[:daily].first).to have_key(:temp)
          expect(data[:daily].first[:temp]).to have_key(:min)
          expect(data[:daily].first[:temp][:min]).to be_a(Float)
          expect(data[:daily].first[:temp]).to have_key(:max)
          expect(data[:daily].first[:temp][:max]).to be_a(Float)
          expect(data[:daily].first).to have_key(:weather)
          expect(data[:daily].first[:weather]).to be_an(Array)
          expect(data[:daily].first[:weather].first).to be_a(Hash)
          expect(data[:daily].first[:weather].first).to have_key(:description)
          expect(data[:daily].first[:weather].first[:description]).to be_a(String)
          expect(data[:daily].first[:weather].first).to have_key(:icon)
          expect(data[:daily].first[:weather].first[:icon]).to be_a(String)
        end
      end

      it 'returns the hourly forecast data for a given location based on longitude and latitude' do
        VCR.use_cassette('hourly_weather_data') do
          location = 'Denver, CO'
          mapquest_data = MapquestService.find_location(location)
          latitude = mapquest_data[:results].first[:locations].first[:latLng][:lat]
          longitude = mapquest_data[:results].first[:locations].first[:latLng][:lng]

          data = WeatherService.find_forecast_for_location(latitude, longitude)

          expect(data).to be_a(Hash)
          expect(data).to have_key(:hourly)
          expect(data[:hourly].count).to eq(48)
          expect(data[:hourly].first).to be_a(Hash)
          expect(data[:hourly].first).to have_key(:dt)
          expect(data[:hourly].first[:dt]).to be_an(Integer)
          expect(data[:hourly].first).to have_key(:temp)
          expect(data[:hourly].first[:temp]).to be_a(Float)
          expect(data[:hourly].first).to have_key(:weather)
          expect(data[:hourly].first[:weather]).to be_an(Array)
          expect(data[:hourly].first[:weather].first).to be_a(Hash)
          expect(data[:hourly].first[:weather].first).to have_key(:description)
          expect(data[:hourly].first[:weather].first[:description]).to be_a(String)
          expect(data[:hourly].first[:weather].first).to have_key(:icon)
          expect(data[:hourly].first[:weather].first[:icon]).to be_a(String)
        end
      end
    end
  end
end
