class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
  set_id :id
end
