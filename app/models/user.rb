class User < ApplicationRecord
  has_secure_password
  before_create :get_api_key

  validates :email, presence: true, uniqueness: true

  has_many :favorites

  def favorites_forecasts
    locations = self.favorites.pluck(:location)
    forecast = Hash.new
    locations.map do |location|
      forecast[location] = GeocodeService.new(location).lat_lng
    end
  end

  private
  def get_api_key
    self.api_key = SecureRandom.uuid
  end
end
