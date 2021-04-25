class Api::V1::BackgroundsController < ApplicationController
  def index
    city = params[:location]
    image_data = UnsplashService.search_images(city)[:results].first
    image = Image.new(image_data, city)

    render json: ImageSerializer.new(image)
  end
end