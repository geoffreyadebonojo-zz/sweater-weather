class ForecastsFacade

  def create_forecast(data, location)
    forecast = ForecastService.new(data)
    Forecast.build(forecast.json, location)
  end

end
