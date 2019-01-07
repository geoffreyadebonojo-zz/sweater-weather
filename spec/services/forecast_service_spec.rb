require 'rails_helper'

describe ForecastService do
  it "Gets JSON Data" do
    VCR.use_cassette("vcr_weather_results") do
      service = ForecastService.new({"lat" => 39.7392358, "long" => -104.990251})
      expect(service).to be_an_instance_of(ForecastService)
      expect(service.json).to be_a(Hash)
    end
  end
end
