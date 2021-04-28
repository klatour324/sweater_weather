class Api::V1::RoadTripController < ApplicationController
  def create
    return error("Invalid parameters") if !params[:origin] || !params[:destination]
    user = User.find_by!(api_key: params[:api_key])
    # start = params[:origin]
    # destination = params[:destination]
    # road_trip = RoadTripFacade.create_new_road_trip(params)

    # trip_data = MapquestService.get_directions(start, destination)
    # coordinates = Coordinate.new(trip_data[:route][:boundingBox])
    # forecast = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
    # road_trip = RoadTrip.new(start, destination, trip_data, forecast)
    road_trip = RoadTripFacade.create_new_road_trip(params[:origin], params[:destination])

    render json: RoadtripSerializer.new(road_trip)
  end
end
