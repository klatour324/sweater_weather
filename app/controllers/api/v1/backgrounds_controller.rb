class Api::V1::BackgroundsController < ApplicationController
  def index
    return error("Invalid location parameter") if ForecastFacade.invalid_location?(params)
    # city = params[:location]
    # image_data = UnsplashService.search_images(city)[:results].first
    # image = Image.new(image_data, city)
    image = BackgroundsFacade.get_image(params[:location])

    render json: ImageSerializer.new(image)
  end
end
