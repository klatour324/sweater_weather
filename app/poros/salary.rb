class Salary
    attr_reader :id,
                :destination

    def initialize(destination, salaries_data, forecast_data)
      @id = id
      @destination = destination
      @salaries_data = salaries_data
      @forecast_data = forecast_data
    end

    # def forecast(destination)
    #   coordinates = MapquestService.find_location(destination)
    #   coordinates = coordinates[:results].first[:locations].first[:latLng]
    #   forecast = WeatherService.find_forecast_for_location(coordinates)
    # end

    def salaries
      salaries = TeleportService.find_salaries_for_location(destination.downcase)
    job_titles = [
                  "Data Analyst","Data Scientist","Mobile Developer",
                  "QA Engineer","Software Engineer",
                  "Systems Administrator","Web Developer"
                 ]
    tech_jobs = @salaries_data[:salaries].find_all do |info|
      job_titles.include?(info[:job][:title])
    end
    tech_jobs.map do |job|
      require "pry"; binding.pry
    end
  end
end
