class BackgroundsFacade
  def self.get_image(location)
    city = location
    image_data = UnsplashService.search_images(city)[:results].first
    image = Image.new(image_data, city)
  end
end
