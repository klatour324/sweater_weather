class Api::V1::SalariesController < ApplicationController
  def index
    location = params[:destination]
    salaries_data = TeleportService.find_salaries_for_location(location)
    # need to add Salary instance here
    # refactor this controller into a Facade
    render json: SalariesSerializer.new(salaries_data)
  end
end
