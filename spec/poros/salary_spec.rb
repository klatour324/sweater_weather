require 'rails_helper'

RSpec.describe Salary do
  describe 'happy path' do
    it 'should build a Salary PORO based on input' do
      destination = 'chicago'
      salary_data = {:salaries=>[
        {:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"}, :salary_percentiles=>{:percentile_25=>46898.18614517015, :percentile_50=>56442.498784333024, :percentile_75=>67929.18726447425}},
        {:job=>{:id=>"DATA-SCIENTIST", :title=>"Data Scientist"}, :salary_percentiles=>{:percentile_25=>71025.60310363481, :percentile_50=>85799.94207526707, :percentile_75=>103647.55438088557}},
        {:job=>{:id=>"MOBILE-DEVELOPER", :title=>"Mobile Developer"}, :salary_percentiles=>{:percentile_25=>50649.8712176599, :percentile_50=>63346.924835957834, :percentile_75=>79226.91192891626}},
        {:job=>{:id=>"QA-ENGINEER", :title=>"QA Engineer"}, :salary_percentiles=>{:percentile_25=>46022.824981352605, :percentile_50=>56733.428314123645, :percentile_75=>69936.64316734018}},
        {:job=>{:id=>"SOFTWARE-ENGINEER", :title=>"Software Engineer"}, :salary_percentiles=>{:percentile_25=>67646.2253013339, :percentile_50=>82451.1152192146, :percentile_75=>100496.16768133474}},
        {:job=>{:id=>"SYSTEMS-ADMINISTRATOR", :title=>"Systems Administrator"}, :salary_percentiles=>{:percentile_25=>54967.079284456646, :percentile_50=>66153.69042177942, :percentile_75=>79616.94187484588}},
        {:job=>{:id=>"WEB-DEVELOPER", :title=>"Web Developer"}, :salary_percentiles=>{:percentile_25=>53704.53793049536, :percentile_50=>66545.38666217329, :percentile_75=>82456.50473241684}}
      ]}
      forecast_data = {
        current: {
          temp: 80.5,
          weather: [{description: 'description'}]
        }

      }

      salary = Salary.new(destination, salary_data, forecast_data)


      expect(salary).to be_a(Salary)
      expect(salary.id).to be(nil)
      expect(salary.destination).to be_a(String)
      # expect(salary.forecast).to be_a(Hash)
      # expect(salary.forecast).to have_key(:summary)
      # expect(salary.forecast[:summary]).to be_a(String)
      # expect(salary.forecast).to have_key(:temperature)
      # expect(salary.forecast[:temperature]).to be_a(String)
      # expect(salary.forecast[:temperature]).to eq("#{(forecast_data[:current][:temp]).to_i} F")
      expect(salary.salaries).to be_an(Array)
      expect(salary.salaries.count).to eq(7)
      expect(salary.salaries.first).to be_a(Hash)
      expect(salary.salaries.first.keys.count).to eq(3)
      expect(salary.salaries.last).to be_a(Hash)
      expect(salary.salaries.last.keys.count).to eq(3)
      expect(salary.salaries.last).to have_key(:title)
      expect(salary.salaries.last[:title]).to be_a(String)
      expect(salary.salaries.last).to have_key(:min)
      expect(salary.salaries.last[:min]).to be_a(String)
      expect(salary.salaries.last).to have_key(:max)
      expect(salary.salaries.last[:max]).to be_a(String)
    end
  end
end
