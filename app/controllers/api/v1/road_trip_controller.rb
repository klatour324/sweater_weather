class Api::V1::RoadTripController < ApplicationController
  def create
    return error("Invalid parameters") if !params[:origin] || !params[:destination]
    user = User.find_by!(api_key: params[:api_key])
    road_trip = RoadTripFacade.create_new_road_trip(params[:origin], params[:destination])

    render json: RoadtripSerializer.new(road_trip)
  end
end
