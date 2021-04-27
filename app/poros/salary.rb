class Salary
  include ActionView::Helpers
    attr_reader :id,
                :destination

    def initialize(destination, salaries_data, forecast_data)
      @id = id
      @destination = destination
      @salaries_data = salaries_data
      @forecast_data = forecast_data
    end

    def forecast
      summary = @forecast_data[:current][:weather].first[:description]
      temperature = "#{(@forecast_data[:current][:temp]).to_i} F"
        {
          summary: summary,
          temperature: temperature
        }
    end

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
      {
        title: job[:job][:title],
        min: number_to_currency(job[:salary_percentiles][:percentile_25]),
        max: number_to_currency(job[:salary_percentiles][:percentile_75])
      }
    end
  end
end
