class GiphyService

  def initialize(description)
    @description = description
  end

  def gif
    get_json["data"][0]["images"]["original"]["url"]
  end

  private

  def key
    ENV['GIPHY_API']
  end

  def get_json
    response = conn.get("?api_key=#{key}&q=#{@description}&limit=1&rating=G&lang=en")
    JSON.parse(response.body)
  end

  def conn
    Faraday.new(:url => 'https://api.giphy.com/v1/gifs/search') do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

end
