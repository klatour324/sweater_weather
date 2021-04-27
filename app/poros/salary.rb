class Salary
    attr_reader :id,
                :destination

    def initialize(destination, salary_data, forecast_data)
      @id = id
      @destination = destination
    end

    def weather_forecast(destination)
      coordinates = MapquestService.find_location(destination)
      coordinates = coordinates[:results].first[:locations].first[:latLng]
      forecast = WeatherService.find_forecast_for_location(coordinates)
    end

    def salaries(destination)
      salaries = TeleportService.find_salaries(destination.downcase)
    job_titles = ["Data Analyst","Data Scientist","Mobile Developer",
            "QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
    job_titles.map do |job_title|
      # require "pry"; binding.pry
    end
  end
end
