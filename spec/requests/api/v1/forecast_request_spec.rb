require 'rails_helper'

RSpec.describe "POST forecast" do
  it "responds with a location param" do

    get "/api/v1/forecasts?location=denver,co"

    expect(response).to be_successful

    body = JSON.parse(response.body)["data"]

    expect(body.keys).to eq(["id", "longitude", "latitude", "summary", "high", "temperature", "low",
      "city", "state", "today_summary", "tonight_summary", "feels_like",
      "humidity", "visibility", "uv_index", "daily_forecasts", "hourly_forecasts"])

    expect(body["daily_forecasts"].count).to eq(8)
    expect(body["daily_forecasts"].first.keys).to eq(["id", "gif", "sunrise", "sunset",
      "precipitation", "icon", "high", "low"])

    expect(body["daily_forecasts"].first["gif"]).to_not be_nil

    expect(body["hourly_forecasts"].count).to eq(49)
    expect(body["hourly_forecasts"].first.keys).to eq(["id", "date", "time",
      "icon", "temp"])

  end
end
