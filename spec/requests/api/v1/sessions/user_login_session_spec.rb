require 'rails_helper'

RSpec.describe 'Users Login Session' do
  before :each do
    @user = User.create(email: "whatever@example.com", password: "password", password_confirmation: "password")
  end

  describe 'happy path' do
    it 'logs an existing user in and creates a new session' do
      user_request_body = {
        email: "whatever@example.com",
        password: "password"
      }
      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      post "/api/v1/sessions", headers: headers, params: user_request_body.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(@user.email).to eq(user_request_body[:email])
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a(String)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:email)
      expect(result[:data][:attributes][:email]).to be_a(String)
      expect(result[:data][:attributes]).to have_key(:api_key)
      expect(result[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'returns an error response if requests password is incorrect' do
      user_request_body = {
        email: "whatever@example.com",
        password: "test"
      }

      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      post "/api/v1/sessions", headers: headers, params: user_request_body.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Password or email is incorrect.")
    end

    it 'returns an error response if requests email is incorrect' do
      user_request_body = {
        email: "hooray@example.com",
        password: "test"
      }

      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      post "/api/v1/sessions", headers: headers, params: user_request_body.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Password or email is incorrect.")
    end

    it 'returns an error response if requests email is missing' do
      user_request_body = {
        password: "test"
      }

      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      post "/api/v1/sessions", headers: headers, params: user_request_body.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Password or email is incorrect.")
    end

    it 'returns an error response if requests password is missing' do
      user_request_body = {
        email: 'whatever@example.com'
      }

      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      post "/api/v1/sessions", headers: headers, params: user_request_body.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Password or email is incorrect.")
    end

    it 'returns an error response if requests is not sent in json format' do
      user_request_body = {
        email: 'whatever@example.com',
        password: 'password'
      }

      post "/api/v1/sessions", headers: headers, params: user_request_body.to_json

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(result[:error]).to eq("Password or email is incorrect.")
    end
  end
end
