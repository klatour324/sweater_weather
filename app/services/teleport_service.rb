class TeleportService
  def self.conn
    Faraday.new(url: 'https://api.teleport.org')
  end

  def self.find_salaries_for_location(location)
    response = conn.get("/api/urban_areas/slug:#{location}/salaries/")

    JSON.parse(response.body, symbolize_names: true)
  end
end
