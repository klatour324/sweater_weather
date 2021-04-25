require 'rails_helper'

RSpec.describe 'Users Registration' do
  describe 'happy path' do
    it 'can register and create a new user' do
      user_request_body = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      post "/api/v1/users", headers: headers, params: user_request_body.to_json

      user = User.find_by(email: user_request_body[:email])

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.content_type).to eq("application/json")
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(user.email).to eq(user_request_body[:email])
      expect(result).to be_a(Hash)
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
end
