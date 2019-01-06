require 'rails_helper'

describe GeocodeService do
  it "Gets JSON Data" do
    service = GeocodeService.new("Dallas, TX")
    expect(service).to be_an_instance_of(GeocodeService)
    expect(service.lat_lng).to be_a(Hash)
  end

end
