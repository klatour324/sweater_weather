require 'rails_helper'

RSpec.describe TeleportService do
  describe 'happy path' do
    describe 'fetch data' do
      it 'returns the tech salaries info for the given location' do
        location = 'Chicago'
        tech_salaries = TeleportService.get_salaries(location)

        expect(tech_salaries).to be_a(Hash)
        expect(tech_salaries).to have_key(:_links)
        expect(tech_salaries).to have_key(:total_pages)
        expect(tech_salaries[:_links]).to be_a(Hash)
        expect(tech_salaries[:_links]).to have_key(:curies)
        expect(tech_salaries[:_links][:curies]).to be_an(Array)
        expect(tech_salaries[:_links][:curies].count).to eq(6)
        expect(tech_salaries[:_links]).to have_key(:self)
        expect(tech_salaries[:_links][:self]).to be_a(Hash)
        expect(tech_salaries[:_links][:self]).to have_key(:href)
        expect(tech_salaries[:_links][:self][:href]).to be_a(String)
        expect(tech_salaries).to have_key(:salaries)
        expect(tech_salaries[:salaries]).to be_an(Array)
        expect(tech_salaries[:salaries].count).to eq(52)
        expect(tech_salaries[:salaries].first).to have_key(:job)
        expect(tech_salaries[:salaries].first[:job]).to be_a(Hash)
        expect(tech_salaries[:salaries].first[:job]).to have_key(:id)
        expect(tech_salaries[:salaries].first[:job][:id]).to be_a(String)
        expect(tech_salaries[:salaries].first[:job]).to have_key(:title)
        expect(tech_salaries[:salaries].first[:job][:title]).to be_a(String)
        expect(tech_salaries[:salaries].first).to have_key(:salary_percentiles)
        expect(tech_salaries[:salaries].first[:salary_percentiles]).to be_a(Hash)
        expect(tech_salaries[:salaries].first[:salary_percentiles]).to have_key(:percentile_25)
        expect(tech_salaries[:salaries].first[:salary_percentiles][:percentile_25]).to be_a(Float)
        expect(tech_salaries[:salaries].first[:salary_percentiles]).to have_key(:percentile_50)
        expect(tech_salaries[:salaries].first[:salary_percentiles][:percentile_50]).to be_a(Float)
        expect(tech_salaries[:salaries].first[:salary_percentiles]).to have_key(:percentile_75)
        expect(tech_salaries[:salaries].first[:salary_percentiles][:percentile_75]).to be_a(Float)
      end
    end
  end
end
