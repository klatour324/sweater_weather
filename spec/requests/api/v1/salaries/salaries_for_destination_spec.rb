require 'rails_helper'

RSpec.describe 'Salaries for Destination' do
  describe 'happy path' do
    it 'it sends the tech salaries for a given destination' do
      destination = "chicago"
      get "/api/v1/salaries?destination=#{destination}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data].count).to eq(3)
      expect(result[:data][:id]).to eq(nil)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq('salaries')
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes].count).to eq(3)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:destination)
      expect(result[:data][:attributes][:destination]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:forecast)
      expect(result[:data][:attributes][:forecast]).to have_key(:summary)
      expect(result[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(result[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(result[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:salaries)
      expect(result[:data][:attributes][:salaries]).to be_an(Array)
      expect(result[:data][:attributes][:salaries].count).to eq(7)
      expect(result[:data][:attributes][:salaries].first).to have_key(:title)
      expect(result[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(result[:data][:attributes][:salaries].first).to have_key(:min)
      expect(result[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(result[:data][:attributes][:salaries].first).to have_key(:max)
      expect(result[:data][:attributes][:salaries].first[:max]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'returns an error response if user sends an empty string for destination' do
      destination = ''
      get "/api/v1/salaries?destination=#{destination}"

      result = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Invalid destination parameter")
    end

    it 'returns an error response if user sends nothing for destination' do
      get "/api/v1/salaries"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Invalid destination parameter")
    end
  end
end
