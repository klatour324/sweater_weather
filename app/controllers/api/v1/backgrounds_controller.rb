class Api::V1::BackgroundsController < ApplicationController
  def index
    return error("Invalid location parameter") if ForecastFacade.invalid_location?(params)

    image = BackgroundsFacade.get_image(params[:location])

    render json: ImageSerializer.new(image)
  end
end
