require 'rails_helper'

RSpec.describe 'Salaries for Destination' do
  describe 'happy path' do
    it 'it sends all the salaries for a given destination' do
      destination = "chicago"
      get "/api/v1/salaries?destination=#{destination}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
  end
end
