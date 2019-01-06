class GeocodeService

  def initialize(location)
    @location = location || "Denver, CO"
  end

  def lat_lng
    get_json(@location)["results"].first["geometry"]["location"]
  end

  private

  def key
    ENV['GOOGLE_GEOCODE_API']
  end

  def get_json(location)
    response = conn.get("?address=#{location}&key=#{key}")

    JSON.parse(response.body)
  end

  def conn
    Faraday.new(:url => 'https://maps.googleapis.com/maps/api/geocode/json') do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end
end
