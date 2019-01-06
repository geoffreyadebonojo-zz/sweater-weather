class User < ApplicationRecord
  has_secure_password
  before_create :get_api_key

  validates :email, presence: true, uniqueness: true

  has_many :favorites

  private
  def get_api_key
    self.api_key = SecureRandom.uuid
  end
end
