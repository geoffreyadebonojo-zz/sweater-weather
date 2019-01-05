class ForecastsFacade

  def create_forecast(data, params)
    results = data[:results][0][:geometry][:location]
    lat = results[:lat]
    long = results[:lng]

    Forecast.new(ForecastService.new(lat, long), params)
  end

end
