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
    @date = (Time.at(data[:dt])).strftime("%Y-%m-%d")
    @sunrise = Time.at(data[:sunrise]).to_s
    @sunset = Time.at(data[:sunset]).to_s
    @min_temp = data[:temp][:min]
    @max_temp = data[:temp][:max]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
