class User < ApplicationRecord
  has_secure_password
  before_create :get_api_key

  validates :email, presence: true, uniqueness: true

  has_many :favorites

  def favorites_forecasts
    locations = self.favorites.pluck(:location)
    locations.map do |location|
      coords = GeocodeService.new(location).lat_lng
      {location: location, forecast: MiniForecast.new(ForecastService.new(coords).json)}
    end
  end

  private
  def get_api_key
    self.api_key = SecureRandom.uuid
  end
end
