class Forecast

  def initialize(data, params)
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
    @city = params[:location] ? params[:location].split(",").first.capitalize : "Denver"
    @state = params[:location] ? params[:location].split(",").last.upcase : "CO"
    @date = Time.at(@id).to_datetime

    @today_summary = today[:summary]
    @tonight_summary = tomorrow[:summary]
    @feels_like = currently[:apparentTemperature]
    @humidity = today[:humidity]
    @visibility = today[:visibility]
    @uv_index = today[:uvIndex]

    @daily_forecasts = daily_forecasts(data)
    @hourly_forecasts = hourly_forecasts(data)
  end

  # Main Box
  def hourly_forecasts(data)
    @hourly_forecasts = data[:hourly][:data].map do |hourly_forecast|
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
        animated_gif: GifGetter.new(daily_forecast[:summary]).gif,
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
  def daily_gif(summary)
    GifGetter.new(summary).gif
  end

end
