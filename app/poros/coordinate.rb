class Coordinate
  attr_reader :lat,
              :long
  def initialize(data)
    @lat = data[:locations].first[:latLng][:lat]
    @long = data[:locations].first[:latLng][:lng]
  end
end
