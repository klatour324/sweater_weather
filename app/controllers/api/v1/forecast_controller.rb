class Api::V1::ForecastController < ApplicationController
  def index
    return error("Invalid location parameter") if params[:location] == '' || params[:location].nil?
    location = params[:location]
    map_data = MapquestService.find_location(location)[:results].first
    coordinates = Coordinate.new(map_data)

    return error("Invalid location parameter") if coordinates.lat == 39.390897 && coordinates.long == -99.066067

    weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.long)
    forecast = Forecast.new(weather)

    render json: ForecastSerializer.new(forecast)
  end
end
