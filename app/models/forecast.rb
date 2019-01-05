class Forecast

  def initialize(data, params)
    @id = data.json[:daily][:data][0][:time]

    long = data.json[:longitude]
    lat = data.json[:latitude]

    currently = data.json[:currently]
    hourly = data.json[:hourly]

    daily = data.json[:daily]
    today = daily[:data][0]
    tomorrow = daily[:data][1]

    # Upper Left Box
    @summary = daily[:summary]
    @temperature = daily[:temperature]
    @high = today[:temperatureHigh]
    @low = today[:temperatureLow]
    @city = params[:location] ? params[:location].split(",").first.capitalize : "No City Given"
    @state = params[:location] ? params[:location].split(",").last.upcase : "No State Given"
    @date = Time.at(@id).to_datetime

    # Upper Right Box
    @today_summary = today[:summary]
    @tonight_summary = tomorrow[:summary]
    @feels_like = data.json[:currently][:apparentTemperature]
    @humidity = today[:humidity]
    @visibility = today[:visibility]
    @uv_index = today[:uvIndex]

    @daily_forecasts = daily_forecasts(data)
    @hourly_forecasts = hourly_forecasts(data)
  end

  # Main Box
  def hourly_forecasts(data)
    @hourly_forecasts = data.json[:hourly][:data].map do |hourly_forecast|
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
    @daily_forecasts = data.json[:daily][:data].map do |daily_forecast|
      forecast = {
        id: daily_forecast[:time],
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
