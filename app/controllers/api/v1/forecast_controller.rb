class Api::V1::ForecastController < ApplicationController
  def index
    return error("Invalid location parameter") if invalid_location?
    location = params[:location]
    map_data = MapquestService.find_location(location)[:results].first
    coordinates = Coordinate.new(map_data)

    return error("Invalid location parameter") if invalid_coordinates(coordinates)

    weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.long)
    forecast = Forecast.new(weather)

    render json: ForecastSerializer.new(forecast)
  end

  private

  def invalid_location?
    return true if params[:location].nil?

    city, state = params[:location].split(',')
    params[:location] == '' || city.nil? || state.nil?
  end

  def invalid_coordinates(coordinates)
    coordinates.lat == 39.390897 && coordinates.long == -99.066067
  end
end
