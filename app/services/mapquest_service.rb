class MapquestService
  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |req|
      req.params['key'] = ENV['MAPQUEST_KEY']
    end
  end

  def self.find_location(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_directions(start, destination)
    response = conn.get("/directions/v2/route") do |req|
      req.params['from'] = start
      req.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
