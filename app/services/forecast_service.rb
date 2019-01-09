class ForecastService

  def initialize(lat_lng_hash)
    @lat = lat_lng_hash["lat"]
    @long = lat_lng_hash["lng"]
  end

  def json
    get_json
  end

  private

  def get_json
    url = "forecast/#{ENV['DARK_SKIES_API']}/#{@lat},#{@long}"
    response = conn.get(url)
    binding.pry
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.darksky.net/")
  end
end
