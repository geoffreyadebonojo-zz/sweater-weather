class HourlyForecast

  def initialize(data)
    @id = data[:id]
    @date = data[:date]
    @time = data[:time].split(" ")[1]
    @icon = data[:icon]
    @temp = data[:temp]
  end

end