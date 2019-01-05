require 'securerandom'

class Forecast

  def initialize(data, params)
    @id = data.json[:daily][:data][0][:time]
    @date = Time.at(@id).to_datetime
    @city = params[:location].split(",").first.capitalize
    @state = params[:location].split(",").last.upcase

    currently = data.json[:currently]
    hourly = data.json[:hourly]
    daily = data.json[:daily]
    today = daily[:data][0]
    tomorrow = daily[:data][1]

    @summary = daily[:summary]
    @today_summary = today[:summary]
    @tonight_summary = tomorrow[:summary]

    @long = data.json[:longitude]
    @lat = data.json[:latitude]

    @high = today[:temperatureHigh]
    @low = today[:temperatureLow]

    @feels_like_high = today[:apparentTemperatureHigh]
    @feels_like_low = today[:apparentTemperatureLow]

    @humidity = today[:humidity]
    @visibility = today[:visibility]
    @uv_index = today[:uvIndex]

  end

end
