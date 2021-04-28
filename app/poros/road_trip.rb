class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, data, forecast)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = find_travel_time(data)
    @weather_at_eta = get_weather_for_destination(data, forecast)
  end

  def find_travel_time(data)
    if data[:info][:messages].blank?
      split_time = (data[:route][:formattedTime]).split(':')
      "#{split_time[0]} hours, #{split_time[1]} minutes"
    else
      'impossible route'
    end
  end

  # def calculate_arrival_time(data, forecast)
  #   split_time = (data[:route][:formattedTime]).split(':')
  #   time_to_seconds = (split_time[0].to_i * 3600) + (split_time[1].to_i * 60)
  #   current_time_for_destination = Time.at(forecast[:current][:dt])
  #   calculated_arrival_time = current_time_for_destination + time_to_seconds
  # end


  def get_weather_for_destination(data, forecast)
    return {} if !data[:info][:messages].blank?
    split_time = (data[:route][:formattedTime]).split(':')
    time_to_seconds = (split_time[0].to_i * 3600) + (split_time[1].to_i * 60)
    current_time_for_destination = Time.at(forecast[:current][:dt])
    calculated_arrival_time = current_time_for_destination + time_to_seconds
    # calculate_arrival_time
    weeks = 167
    days = 48

    if split_time[0].to_i > weeks
      {}
    elsif split_time[0].to_i < days
      hourly_forecast = forecast[:hourly].find do |forecast_hour|
        Time.at(forecast_hour[:dt]) > calculated_arrival_time
      end
      {
        temperature: hourly_forecast[:temp],
        conditions: hourly_forecast[:weather].first[:description]
      }
    else
      daily_forecast = forecast[:daily].find do |forecast_day|
        Time.at(forecast_day[:dt]) > calculated_arrival_time
      end
      {
        temperature: daily_forecast[:temp],
        conditions: daily_forecast[:weather].first[:description]
      }
    end
  end
end
