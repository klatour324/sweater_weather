class TeleportService
  def self.conn
    Faraday.new(url: 'https://api.teleport.org')
  end

  def self.find_salaries_for_location(location)
    response = conn.get("/api/urban_areas/slug:#{location}/salaries/")
    if response.body == 'Sorry, but the page you were trying to view does not exist.'
      nil
    else
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
