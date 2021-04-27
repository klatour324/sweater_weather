class SalariesFacade
  def self.search(location)
    salaries_data = TeleportService.find_salaries_for_location(location)
    coordinate_results = MapquestService.find_location(location)
    coordinates = coordinate_results[:results].first[:locations].first[:latLng]
    forecast_data = WeatherService.find_forecast_for_location(coordinates[:lat], coordinates[:lng])

    Salary.new(location, salaries_data, forecast_data)
  end
end
