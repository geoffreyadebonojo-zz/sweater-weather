require 'rails_helper'

describe GiphyService do
  it "Gets JSON Data" do
    VCR.use_cassette("vcr_giphy_results") do
      service = GiphyService.new("Partly Cloudy")
      expect(service).to be_an_instance_of(GiphyService)
      expect(service.gif).to be_a(String)
      #TODO: test for specific information
    end
  end
end
