class Api::V1::SalariesController < ApplicationController
  def index
    return error("Invalid destination parameter") if invalid_destination?(params)
    salaries = SalariesFacade.search(params[:destination])

    render json: SalariesSerializer.new(salaries)
  end

  private
  def invalid_destination?(params)
    city = params[:destination]
    return true if city.nil? || city == ''
  end
end
