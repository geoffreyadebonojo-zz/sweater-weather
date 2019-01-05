class ForecastService

  def initialize(lat, long)
    # @geocode = GeocodeService.new
    @lat = lat
    @long = long
  end

  def json
    get_json
  end

  private

  def get_json
    url = "forecast/#{ENV['DARK_SKIES_API']}/#{@lat},#{@long}"
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  # def key
  #   @key = ENV['DARK_SKIES_API']
  # end

  def conn
    Faraday.new(url: "https://api.darksky.net/")
  end
end
