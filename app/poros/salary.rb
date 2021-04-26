class Salary
    attr_reader :destination,
                :forecast,
                :salaries


    def initialize(data)
      @destination = data[:destination]
      @forecast = CurrentWeather.new(data[:current])
      @salaries = data[:salaries]
    end

    # def tech_salaries(data)
    #
    # end
end
