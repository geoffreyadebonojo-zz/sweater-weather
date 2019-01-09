require 'rails_helper'

RSpec.describe "POST forecast" do
  it "responds with a location param" do

    get "/api/v1/forecasts?location=denver,co"

    expect(response).to be_successful

    body = JSON.parse(response.body)["data"]

    expect(body.keys).to eq(["id", "longitude", "latitude", "summary", "high", "temperature", "low",
      "city", "state", "today_summary", "tonight_summary", "feels_like",
      "humidity", "visibility", "uv_index", "daily_forecasts", "hourly_forecasts"])
    expect(body["id"]).to be_an(Integer)
    expect(body["longitude"]).to be_a(Float)
    expect(body["latitude"]).to be_a(Float)

    expect(body["summary"]).to be_a(String)
    expect(body["high"]).to be_an(Float)
    expect(body["temperature"]).to be_an(Float)
    expect(body["low"]).to be_an(Float)
    expect(body["city"]).to be_an(String)
    expect(body["state"]).to be_an(String)
    expect(body["today_summary"]).to be_an(String)
    expect(body["tonight_summary"]).to be_an(String)

    expect(body["feels_like"]).to be_an(Float)
    expect(body["humidity"]).to be_an(Float)
    expect(body["visibility"]).to be_an(Integer)
    expect(body["uv_index"]).to be_an(Integer)

    expect(body["daily_forecasts"].count).to eq(8)
    expect(body["daily_forecasts"].first.keys).to eq(["id", "gif", "sunrise", "sunset",
      "precipitation", "icon", "high", "low"])
    expect(body["daily_forecasts"].first["id"]).to be_an(Integer)
    expect(body["daily_forecasts"].first["gif"]).to be_a(String)
    # expect sunrise and sunset to be convertable to date format
    expect(body["daily_forecasts"].first["sunrise"].to_date).to be_a(Date)
    expect(body["daily_forecasts"].first["sunset"].to_date).to be_a(Date)
    expect(body["daily_forecasts"].first["precipitation"]).to be_an(Integer)
    expect(body["daily_forecasts"].first["icon"]).to be_a(String)
    expect(body["daily_forecasts"].first["high"]).to be_an(Float)
    expect(body["daily_forecasts"].first["low"]).to be_an(Float)

    expect(body["hourly_forecasts"].count).to eq(49)
    expect(body["hourly_forecasts"].first.keys).to eq(["id", "date", "time",
      "icon", "temp"])
    expect(body["hourly_forecasts"].first["id"]).to be_an(Integer)
    expect(body["hourly_forecasts"].first["date"].to_date).to be_a(Date)
    expect(body["hourly_forecasts"].first["time"].to_time).to be_a(Time)
    expect(body["hourly_forecasts"].first["icon"]).to be_a(String)
    expect(body["hourly_forecasts"].first["temp"]).to be_an(Float)

  end
end
