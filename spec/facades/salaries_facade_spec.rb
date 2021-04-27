require 'rails_helper'

RSpec.describe SalariesFacade do
  describe 'happy path' do
    it 'can get the salaries and forecast for a given destination' do
      destination = 'chicago'
      salaries = SalariesFacade.search(destination)

      expect(salaries).to be_a(Salary)
      expect(salaries.destination).to be_a(String)
      expect(salaries.forecast).to be_a(Hash)
      expect(salaries.forecast).to have_key(:summary)
      expect(salaries.forecast[:summary]).to be_a(String)
      expect(salaries.forecast).to have_key(:temperature)
      expect(salaries.forecast[:temperature]).to be_a(String)
      expect(salaries.salaries).to be_an(Array)
      expect(salaries.salaries.first).to be_a(Hash)
      expect(salaries.salaries.first).to have_key(:title)
      expect(salaries.salaries.first[:title]).to be_a(String)
      expect(salaries.salaries.first).to have_key(:min)
      expect(salaries.salaries.first[:min]).to be_a(String)
      expect(salaries.salaries.first).to have_key(:max)
      expect(salaries.salaries.first[:max]).to be_a(String)
    end
  end
end
