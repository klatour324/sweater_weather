class RoadTripFacade
  def self.create_new_road_trip(start, destination)
    trip_data = MapquestService.get_directions(start, destination)
    coordinates = Coordinate.new(trip_data[:route][:boundingBox])
    forecast = WeatherService.find_forecast_for_location(coordinates.lat, coordinates.lng)
    RoadTrip.new(start, destination, trip_data, forecast)
  end
end
