require 'rails_helper'

RSpec.describe 'Forecast Index Page' do
  describe 'happy path' do
    it 'sends the current forecast for the given valid location' do
      location = 'denver,co'
      get "/api/v1/forecast?location=#{location}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result[:data].count).to eq(3)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('forecast')
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes].count).to eq(3)

      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:current_weather)
      expect(result[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(result[:data][:attributes][:current_weather].count).to eq(10)
      expect(result[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(result[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(result[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(result[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(result[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(result[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(result[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(result[:data][:attributes][:current_weather][:humidity]).to be_an(Integer).or be_a(Float)
      expect(result[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(result[:data][:attributes][:current_weather][:uvi]).to be_an(Integer).or be_a(Float)
      expect(result[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(result[:data][:attributes][:current_weather][:visibility]).to be_an(Integer).or be_a(Float)
      expect(result[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(result[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(result[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(result[:data][:attributes][:current_weather][:icon]).to be_a(String)

      expect(result[:data][:attributes][:current_weather]).to_not have_key(:pressure)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:clouds)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_speed)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_deg)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_gust)
    end

    it 'sends the daily forecast for the given valid location' do
      location = 'denver,co'
      get "/api/v1/forecast?location=#{location}"

      result = JSON.parse(response.body, symbolize_names: true)
      daily = result[:data][:attributes][:daily_weather]

      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:daily_weather)
      expect(daily).to be_an(Array)
      expect(daily.count).to eq(5)
      expect(daily.first).to be_a(Hash)
      expect(daily.first).to have_key(:date)
      expect(daily.first[:date]).to be_a(String)
      expect(daily.first).to have_key(:sunrise)
      expect(daily.first[:sunrise]).to be_a(String)
      expect(daily.first).to have_key(:sunset)
      expect(daily.first[:sunset]).to be_a(String)
      expect(daily.first).to have_key(:max_temp)
      expect(daily.first[:max_temp]).to be_a(Float)
      expect(daily.first).to have_key(:min_temp)
      expect(daily.first[:min_temp]).to be_a(Float)
      expect(daily.first).to have_key(:conditions)
      expect(daily.first[:conditions]).to be_a(String)
      expect(daily.first).to have_key(:icon)
      expect(daily.first[:icon]).to be_a(String)

      expect(daily.first).to_not have_key(:moonrise)
      expect(daily.first).to_not have_key(:moonset)
      expect(daily.first).to_not have_key(:feels_like)
      expect(daily.first).to_not have_key(:pressure)
      expect(daily.first).to_not have_key(:humidity)
      expect(daily.first).to_not have_key(:dew_point)
      expect(daily.first).to_not have_key(:wind_speed)
      expect(daily.first).to_not have_key(:wind_deg)
      expect(daily.first).to_not have_key(:wind_gust)
      expect(daily.first).to_not have_key(:clouds)
      expect(daily.first).to_not have_key(:pop)
      expect(daily.first).to_not have_key(:uvi)
    end

    it 'sends the hourly forecast for the given valid location' do
      location = 'denver,co'
      get "/api/v1/forecast?location=#{location}"

      result = JSON.parse(response.body, symbolize_names: true)
      hourly = result[:data][:attributes][:hourly_weather]

      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:hourly_weather)
      expect(hourly).to be_an(Array)
      expect(hourly.count).to eq(8)
      expect(hourly.first).to be_a(Hash)
      expect(hourly.first).to have_key(:time)
      expect(hourly.first[:time]).to be_a(String)
      expect(hourly.first).to have_key(:temperature)
      expect(hourly.first[:temperature]).to be_a(Float)
      expect(hourly.first).to have_key(:conditions)
      expect(hourly.first[:conditions]).to be_a(String)
      expect(hourly.first).to have_key(:icon)
      expect(hourly.first[:icon]).to be_a(String)

      expect(hourly.first).to_not have_key(:feels_like)
      expect(hourly.first).to_not have_key(:pressure)
      expect(hourly.first).to_not have_key(:humidity)
      expect(hourly.first).to_not have_key(:dew_point)
      expect(hourly.first).to_not have_key(:uvi)
      expect(hourly.first).to_not have_key(:clouds)
      expect(hourly.first).to_not have_key(:visibility)
      expect(hourly.first).to_not have_key(:wind_speed)
      expect(hourly.first).to_not have_key(:wind_deg)
      expect(hourly.first).to_not have_key(:wind_gust)
      expect(hourly.first).to_not have_key(:pop)
    end
  end
end
