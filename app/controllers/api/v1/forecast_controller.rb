class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    map_data = MapquestService.find_location(location)[:results].first
    coordinates = Coordinate.new(map_data)
    weather = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.long)
    forecast = Forecast.new(weather)

    render json: ForecastSerializer.new(forecast)
  end
end
