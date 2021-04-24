require 'rails_helper'

RSpec.describe 'Forecast Index Page' do
  describe 'happy path' do
    it 'sends the forecast for the given valid location' do
      get '/api/v1/forecast?location=denver,co'

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_successful
      expect(result.response).to eq(200)
      expect(result[:data].count).to eq(3)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(null)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('forecast')
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:current_weather)
      expect(result[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(result[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(result[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(result[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(result[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
    end
  end
end
