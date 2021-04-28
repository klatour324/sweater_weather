require 'rails_helper'

RSpec.describe 'Backgrounds Index Page' do
  describe 'happy path' do
    it 'sends an image for the background for a given location' do
      VCR.use_cassette('background_image_request') do
        location = 'denver,co'
        get "/api/v1/backgrounds?location=#{location}"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data][:id]).to eq(nil)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq('image')
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes].count).to eq(1)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes][:image]).to have_key(:location)
        expect(result[:data][:attributes][:image][:location]).to be_a(String)
        expect(result[:data][:attributes][:image]).to have_key(:image_url)
        expect(result[:data][:attributes][:image][:image_url]).to be_a(String)
        expect(result[:data][:attributes][:image]).to have_key(:credit)
        expect(result[:data][:attributes][:image][:credit]).to be_a(Hash)
        expect(result[:data][:attributes][:image][:credit]).to have_key(:source)
        expect(result[:data][:attributes][:image][:credit][:source]).to be_a(String)
        expect(result[:data][:attributes][:image][:credit]).to have_key(:author)
        expect(result[:data][:attributes][:image][:credit][:author]).to be_a(String)
        expect(result[:data][:attributes][:image][:credit]).to have_key(:author_profile)
        expect(result[:data][:attributes][:image][:credit][:author_profile]).to be_a(String)

        expect(result[:data][:attributes]).to_not have_key(:created_at)
        expect(result[:data][:attributes]).to_not have_key(:updated_at)
        expect(result[:data][:attributes]).to_not have_key(:width)
        expect(result[:data][:attributes]).to_not have_key(:height)
        expect(result[:data][:attributes]).to_not have_key(:color)
        expect(result[:data][:attributes]).to_not have_key(:blur_hash)
        expect(result[:data][:attributes]).to_not have_key(:alt_description)
      end
    end
  end

  describe 'sad path' do
    it 'returns an error response if no location is provided' do
      location = ''
      get "/api/v1/backgrounds?location=#{location}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Invalid location parameter")
    end
  end
end
