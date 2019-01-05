require 'rails_helper'

describe ForecastService do
  it "Gets JSON Data" do
    service = ForecastService.new(39.7392358, -104.990251)
    expect(service).to be_an_instance_of(ForecastService)
    expect(service.json).to be_a(Hash)
    expect(service.json).to have_key(:currently)
    expect(service.json).to have_key(:hourly)
    expect(service.json).to have_key(:daily)
  end

end