class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :min_temp,
              :max_temp,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @date = (Time.at(data.first[:dt])).strftime("%Y-%m-%d")
    @sunrise = Time.at(data.first[:sunrise]).to_s
    @sunset = Time.at(data.first[:sunset]).to_s
    @min_temp = data.first[:temp][:min]
    @max_temp = data.first[:temp][:max]
    @conditions = data.first[:weather].first[:description]
    @icon = data.first[:weather].first[:icon]
  end

  # def convert_time(time)
  #   datetime = Time.at(time)
  #   datetime.strftime("%Y-%m-%d%H:%M:%S%z")
  # end
end
