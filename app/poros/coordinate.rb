class Coordinate
  attr_reader :lat,
              :lng

  def initialize(data)
    @lat = find_lat(data)
    @lng = find_lng(data)
  end

  def find_lat(data)
    if data[:locations]
      data[:locations].first[:latLng][:lat]
    else
      data[:lr][:lat]
    end
  end

  def find_lng(data)
    if data[:locations]
      data[:locations].first[:latLng][:lng]
    else
      data[:lr][:lng]
    end
  end
end
