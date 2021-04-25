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
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(user.email).to eq(user_request_body[:email])
      expect(response.body).to be_a(Hash)
      expect(response.body).to have_key(:data)
      expect(response.body[:data]).to be_a(Hash)
      expect(response.body[:data]).to have_key(:type)
      expect(response.body[:data][:type]).to be_a(String)
      expect(response.body[:data]).to have_key(:id)
      expect(response.body[:data][:id]).to be_a(String)
      expect(response.body[:data]).to have_key(:attributes)
      expect(response.body[:data][:attributes]).to be_a(Hash)
      expect(response.body[:data][:attributes]).to have_key(:email)
      expect(response.body[:data][:attributes][:email]).to be_a(String)
      expect(response.body[:data][:attributes]).to have_key(:api_key)
      expect(response.body[:data][:attributes][:email][:api_key]).to be_a(String)
    end
  end
end
