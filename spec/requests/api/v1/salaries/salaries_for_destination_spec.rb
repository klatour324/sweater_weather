require 'rails_helper'

RSpec.describe 'Salaries for Destination' do
  describe 'happy path' do
    it 'it sends all the salaries for a given destination' do
      destination = "chicago"
      get "/api/v1/salaries?destination=#{destination}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(result).to be_a(Hash)
      expect(result).to have_key([:data])
      expect(result[:data]).to be_a(Hash)
      expect(result[:data].count).to eq(3)
      expect(result[:data][:id]).to eq(nil)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('salaries')
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes].count).to eq(4)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:destionation)
      expect(result[:data][:attributes][:destination]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:forecast)
    end
  end
end
