class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.at(data.first[:dt]).strftime("%H:%M:%S")
    @temperature = data.first[:temp]
    @conditions = data.first[:weather].first[:description]
    @icon = data.first[:weather].first[:icon]
  end
end
