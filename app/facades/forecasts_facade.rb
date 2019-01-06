class ForecastsFacade

  def create_forecast(data, params)
    forecast = ForecastService.new(data)
    Forecast.new(forecast.json, params)
  end

end
