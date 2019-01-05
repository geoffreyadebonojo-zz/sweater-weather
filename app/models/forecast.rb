class Forecast

  def initialize(data, params)
    @id = data.json[:daily][:data][0][:time]

    currently = data.json[:currently]
    hourly = data.json[:hourly]
    daily = data.json[:daily]
    today = daily[:data][0]
    tomorrow = daily[:data][1]
    long = data.json[:longitude]
    lat = data.json[:latitude]

    # Upper Left Box
    @summary = daily[:summary]
    @temperature = daily[:temperature]
    @high = today[:temperatureHigh]
    @low = today[:temperatureLow]
    @city = params[:location].split(",").first.capitalize
    @state = params[:location].split(",").last.upcase
    @date = Time.at(@id).to_datetime

    # Upper Right Box
    @today_summary = today[:summary]
    @tonight_summary = tomorrow[:summary]
    @feels_like = data.json[:currently][:apparentTemperature]
    @humidity = today[:humidity]
    @visibility = today[:visibility]
    @uv_index = today[:uvIndex]

    # Main Box
    @hourly_forecasts = data.json[:hourly][:data].map do |hourly_forecast|
      forecast = {
        date: Time.at(hourly_forecast[:time]).to_date,
        time: Time.at(hourly_forecast[:time]).to_s.split("T").last.split(".").first,
        icon: hourly_forecast[:icon],
        temp: hourly_forecast[:temperature]
      }
      # HourlyForecast.new(forecast)
    end

    @daily_forecasts = data.json[:daily][:data].map do |daily_forecast|
      {
        sunrise: Time.at(daily_forecast[:sunriseTime]),
        sunset: Time.at(daily_forecast[:sunsetTime]),
        precipitation: daily_forecast[:precipProbability] * 100,
        icon: daily_forecast[:icon],
        high: daily_forecast[:temperatureHigh],
        low: daily_forecast[:temperatureLow]
      }
      # DailyForecast.new(forecast)
    end
    binding.pry
  end

end
