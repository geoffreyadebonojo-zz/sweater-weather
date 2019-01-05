class GeocodeService

  def initialize(location)
    @location = location
    @key = ENV['GOOGLE_GEOCODE_API']
  end
  
  def json
    url = "maps/api/geocode/json?address=#{@location}&key=AIzaSyD7ZvC6r_LNgeYBRoDP2JesDHunEnt6TTA"
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  private


  def conn
    Faraday.new(url: "https://maps.googleapis.com/")
  end
end