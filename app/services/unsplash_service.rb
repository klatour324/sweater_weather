class UnsplashService
  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |req|
      req.headers['Authorization'] = "Client-ID #{ENV['UNSPLASH_KEY']}"
    end
  end

  def self.search_photos(location)
    response = conn.get('/search/photos') do |req|
      req.params['query'] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
