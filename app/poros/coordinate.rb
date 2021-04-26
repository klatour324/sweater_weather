class Coordinate
  attr_reader :lat,
              :long
  def initialize(data)
    @lat = find_lat(data)
    @long = find_lng(data)
  end

  def find_lat(data)
    if data[:results].first[:locations].empty?
      0
    else
      data[:locations].first[:latLng][:lat]
    end
  end

  def find_long(data)
    if data[:results].first[:locations].empty?
      0
    else
      data[:locations].first[:latLng][:lng]
    end
  end
end
