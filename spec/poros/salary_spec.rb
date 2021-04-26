require 'rails_helper'

RSpec.describe Salary do
  describe 'happy path' do
    it 'should build a Salary PORO based on input' do
      location = 'chicago'
      data = MapquestService.find_location(location)
      latitude = data[:results].first[:locations].first[:latLng][:lat]
      longitude = data[:results].first[:locations].first[:latLng][:lng]
      weather = WeatherService.find_forecast_for_location(latitude, longitude)
      salary_data = TeleportService.find_salaries_for_location(location)
      salary = Salary.new(salary_data, weather)

      expect(salary).to be_a(Salary)
      expect(salary.location).to be_a(String)
      expect(salary.forecast).to be_a(Hash)
      expect(salary.forecast).to have_key(:summary)
      expect(salary.forecast[:summary]).to be_a(String)
      expect(salary.forecast).to have_key(:temperature)
      expect(salary.forecast[:temperature]).to be_a(String)
      expect(salary.salaries).to be_an(Array)
      expect(salary.salaries.count).to eq(7)
      expect(salary.salaries.first).to be_a(Hash)
      expect(salary.salaries.first.keys.count).to eq(3)
      expect(salary.salaries.last).to (Hash)
      expect(salary.salaries.last.keys.count).to eq(3)
    end
  end
end
