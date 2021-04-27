class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by!(api_key: params[:api_key])
    start = params[:origin]
    destination = params[:destination]
    trip_data = MapquestService.get_directions(start, destination)
    forecast = ForecastFacade.get_forecast(destination)
    road_trip = RoadTrip.new(start, destination, trip_data, forecast)

    render json: RoadtripSerializer.new(road_trip)
  end
end
