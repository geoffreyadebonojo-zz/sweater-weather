class DailyForecast

  def initialize(data)
    @id = data[:id]
    @gif = data[:animated_gif]
    @sunrise = Time.at(data[:sunrise]).strftime("%H:%m:%S")
    @sunset = Time.at(data[:sunset]).strftime("%H:%m:%S")
    @precipitation = data[:precipitation]
    @icon = data[:icon]
    @high = data[:high]
    @low = data[:low]
  end

end
