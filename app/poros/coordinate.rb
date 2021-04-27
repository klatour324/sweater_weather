class Coordinate
  attr_reader :lat,
              :long

  def initialize(data)
    @lat = find_lat(data)
    @long = find_lng(data)
  end

  def find_lat(data)
    data[:locations].first[:latLng][:lat]
  end

  def find_lng(data)
    data[:locations].first[:latLng][:lng]
  end
end
