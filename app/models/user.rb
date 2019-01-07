class User < ApplicationRecord
  has_secure_password
  before_create :get_api_key

  validates :email, presence: true, uniqueness: true

  has_many :favorites

  def favorites_forecasts
    locations = self.favorites.pluck(:location)
    forecast = {}
    locations.each do |location|
      coords = GeocodeService.new(location).lat_lng
      forecast[location] = MiniForecast.new(ForecastService.new(coords).json)
    end
    forecast
  end

  private
  def get_api_key
    self.api_key = SecureRandom.uuid
  end
end
