# class RoadTripFacade
#   def self.create_new_road_trip(params)
#     return "Invalid parameters" if !params[:origin] || !params[:destination]
#     user = User.find_by!(api_key: params[:api_key])
#     start = params[:origin]
#     destination = params[:destination]
#     road_trip_data = combine_data(start, destination)
#     road_trip = RoadTrip.new(road_trip_data)
#   end
#
#   def self.find_route(start, destination)
#     trip_data = MapquestService.get_directions(start, destination)
#   end
#
#   def self.get_forecast(trip_data)
#     coordinates = Coordinate.new(trip_data[:route][:boundingBox])
#     forecast = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
#   end
#
#   def self.user_params
#     params[:email] = params[:email].downcase
#     params.permit(:email, :password, :password_confirmation)
#   end
#
#   def self.combine_data(start, destination)
#
#     trip_data = {
#       origin: start,
#       destination: destination,
#       route: find_route(start, destination),
#       weather: nil
#     }
#     trip_data[:weather] = get_forecast(trip_data[:route]) if trip_data[:route]
#
#     trip_data
#   end
# end
