require 'rails_helper'

RSpec.describe Salary do
  describe 'happy path' do
    it 'should build a Salary PORO based on input' do
      location = 'chicago'
      salary_data = TeleportService.find_salaries_for_location(location)
      salary = Salary.new(salary_data)

      expect(salary).to be_a(Salary)
      expect(salary.location).to be_a(String)
    end
  end
end
