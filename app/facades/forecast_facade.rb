class ForecastFacade
  def self.get_forecast(location)
    coordinates = get_coordinates(location)
    weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
    Forecast.new(weather)
  end

  def self.get_coordinates(location)
    map_data = MapquestService.find_location(location)[:results].first
    Coordinate.new(map_data)
  end

  def self.invalid_location?(params)
    return true if params[:location].nil?

    city, state = params[:location].split(',')
    params[:location] == '' || city.blank? || state.blank?
  end
end
