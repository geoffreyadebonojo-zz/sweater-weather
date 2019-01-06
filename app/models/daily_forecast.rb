class DailyForecast

  def initialize(data)
    @id = data[:id]
    @sunrise = data[:sunrise]
    @sunset = data[:sunset]
    @precipitation = data[:precipitation]
    @icon = data[:icon]
    @high = data[:high]
    @low = data[:low]
  end

end