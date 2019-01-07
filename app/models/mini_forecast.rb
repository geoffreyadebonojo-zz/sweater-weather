class MiniForecast

  def initialize(data)
    @id = data[:daily][:data][0][:time]

    @longitude = data[:longitude]
    @latitude = data[:latitude]

    currently = data[:currently]
    hourly = data[:hourly]

    daily = data[:daily]
    today = daily[:data][0]
    tomorrow = daily[:data][1]

    @summary = currently[:summary]
    @high = today[:temperatureHigh]
    @temperature = currently[:temperature]
    @low = today[:temperatureLow]

    @today_summary = today[:summary]
    @tonight_summary = tomorrow[:summary]
    @feels_like = currently[:apparentTemperature]
    @humidity = today[:humidity]

  end
end
