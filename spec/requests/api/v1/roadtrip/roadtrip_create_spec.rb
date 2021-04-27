require 'rails_helper'

RSpec.describe 'Road Trip Create' do
  before :each do
    @user = User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")
  end

  describe 'happy path' do
    it 'creates a new roadtrip and gives the duration of trip and weather conditions for a valid trip' do
      VCR.use_cassette('denver_to_pueblo') do
        road_trip_request_body = {
            origin: 'Denver,CO',
            destination: 'Pueblo,CO',
            api_key: @user.api_key
        }

        headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        post "/api/v1/road_trip", headers: headers, params: road_trip_request_body.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to have_key(:data)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq('roadtrip')
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to eq(nil)
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].keys.count).to eq(4)
        expect(result[:data][:attributes]).to have_key(:start_city)
        expect(result[:data][:attributes][:start_city]).to be_a(String)
        expect(result[:data][:attributes][:start_city]).to eq(road_trip_request_body[:origin])
        expect(result[:data][:attributes]).to have_key(:end_city)
        expect(result[:data][:attributes][:end_city]).to be_a(String)
        expect(result[:data][:attributes][:end_city]).to eq(road_trip_request_body[:destination])
        expect(result[:data][:attributes]).to have_key(:travel_time)
        expect(result[:data][:attributes][:travel_time]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:weather_at_eta)
        expect(result[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(result[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(result[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(result[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(result[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end

    it 'creates a new roadtrip and gives the hourly duration of trip and weather conditions for a valid trip longer than 48 hours' do
      VCR.use_cassette('anchorage_to_chicago') do
        road_trip_request_body = {
            origin: 'Anchorage, AK',
            destination: 'Chicago, IL',
            api_key: @user.api_key
        }

        headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        post "/api/v1/road_trip", headers: headers, params: road_trip_request_body.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result[:data][:attributes][:start_city]).to eq(road_trip_request_body[:origin])
        expect(result[:data][:attributes]).to have_key(:end_city)
        expect(result[:data][:attributes][:end_city]).to eq(road_trip_request_body[:destination])
        expect(result[:data][:attributes][:travel_time]).to eq("59 hours, 27 minutes")
        expect(result[:data][:attributes]).to have_key(:weather_at_eta)
        expect(result[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(result[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(result[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      end
    end

    it 'creates a new roadtrip and gives the minutely duration of trip and weather conditions for a valid trip' do
      VCR.use_cassette('skokie_to_chicago') do
        road_trip_request_body = {
            origin: 'Skokie, IL',
            destination: 'Chicago, IL',
            api_key: @user.api_key
        }

        headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
        post "/api/v1/road_trip", headers: headers, params: road_trip_request_body.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result[:data][:attributes][:start_city]).to eq(road_trip_request_body[:origin])
        expect(result[:data][:attributes][:end_city]).to eq(road_trip_request_body[:destination])
        expect(result[:data][:attributes][:travel_time]).to eq("00 hours, 18 minutes")
        expect(result[:data][:attributes]).to have_key(:weather_at_eta)
        expect(result[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(result[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(result[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      end
    end
  end

  # describe 'sad path' do
  #   it 'returns a 401 unauthorized response if request is sent without an api key' do
  #     VCR.use_cassette('401_unauthorized_error') do
  #       road_trip_request_body = {
  #           origin: 'Denver,CO',
  #           destination: 'Pueblo,CO'
  #       }
  #
  #       headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
  #
  #       post "/api/v1/road_trip", headers: headers, params: road_trip_request_body.to_json
  #
  #       result = JSON.parse(response.body, symbolize_names: true)
  #
  #       expect(response).to_not be_successful
  #       expect(response.status).to eq(401)
  #       expect(response.status).to eq(401)
  #     end
end
