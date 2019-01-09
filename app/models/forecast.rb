class Forecast

  def self.build(data, location)
    forecast = Forecast.new(data, location)
    @daily_forecasts = forecast.daily_forecasts(data)
    @hourly_forecasts = forecast.hourly_forecasts(data)
    forecast
  end

  def initialize(data, location)
    currently = data[:currently]
    hourly = data[:hourly]
    daily = data[:daily]
    today = daily[:data][0]
    tomorrow = daily[:data][1]

    @id = data[:daily][:data][0][:time]
    @longitude = data[:longitude]
    @latitude = data[:latitude]

    @summary = currently[:summary]
    @high = today[:temperatureHigh]
    @temperature = currently[:temperature]
    @low = today[:temperatureLow]
    @city, @state = location.split(",")

    @today_summary = today[:summary]
    @tonight_summary = tomorrow[:summary]
    @feels_like = currently[:apparentTemperature]
    @humidity = today[:humidity]
    @visibility = today[:visibility]
    @uv_index = today[:uvIndex]
  end

  # TODO build superclass to inherit from here

  def hourly_forecasts(data)
    @hourly_forecasts = data[:hourly][:data].map do |hourly_forecast|
      #remove to separate method
      forecast = {
        id: hourly_forecast[:time],
        date: Time.at(hourly_forecast[:time]).to_date,
        time: Time.at(hourly_forecast[:time]).to_s.split("T").last.split(".").first,
        icon: hourly_forecast[:icon],
        temp: hourly_forecast[:temperature]
      }
      HourlyForecast.new(forecast)
    end
  end

  def daily_forecasts(data)
    @daily_forecasts = data[:daily][:data].map do |daily_forecast|
      forecast = {
        id: daily_forecast[:time],
        animated_gif: GifGetter.new(daily_forecast[:icon]).gif,
        sunrise: Time.at(daily_forecast[:sunriseTime]),
        sunset: Time.at(daily_forecast[:sunsetTime]),
        precipitation: daily_forecast[:precipProbability],
        icon: daily_forecast[:icon],
        high: daily_forecast[:temperatureHigh],
        low: daily_forecast[:temperatureLow]
      }
      DailyForecast.new(forecast)
    end
  end

end
