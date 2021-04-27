class Api::V1::SalariesController < ApplicationController
  def index
    # location = params[:destination]
    # coordinates = MapquestService.find_location(location)
    # coordinates = coordinates[:results].first[:locations].first[:latLng]
    # forecast = WeatherService.find_forecast_for_location(coordinates)
    # salaries_data = TeleportService.find_salaries_for_location(location)
    # salary = Salary.new(location, salaries_data, forecast_data)
    salaries = SalariesFacade.search(params[:destination])

    render json: SalariesSerializer.new(salaries)
  end
end
