class Api::V1::SalariesController < ApplicationController
  def index
    location = params[:destination]
    def conn
      Faraday.new(url: 'https://api.teleport.org')
    end

    def find_salaries_for_location(location)
      response = conn.get("api/urban_areas/#{location}/salaries/")

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
