require 'rails_helper'

RSpec.describe "User POSTS to the forecast endpoint" do
  it "responds with a location param" do

    get "/api/v1/forecasts?location=denver,co"

    expect(response).to be_successful

    body = JSON.parse(response.body)

    expect(body.keys).to eq(["id", "longitude", "latitude", "summary", "high", "temperature", "low",
      "city", "state", "date", "today_summary", "tonight_summary", "feels_like",
      "humidity", "visibility", "uv_index", "daily_forecasts", "hourly_forecasts"])

    expect(body["daily_forecasts"].count).to eq(8)
    expect(body["daily_forecasts"].first.keys).to eq(["id", "sunrise", "sunset",
      "precipitation", "icon", "high", "low"])

    expect(body["hourly_forecasts"].count).to eq(49)
    expect(body["hourly_forecasts"].first.keys).to eq(["id", "date", "time",
      "icon", "temp"])

  end

  # it "responds without a location param" do
  #
  #   get "/api/v1/forecasts"
  #   expect(response).to be_successful
  #
  # end
end
