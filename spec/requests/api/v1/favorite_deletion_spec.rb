require 'rails_helper'

RSpec.describe "DELETES favorite" do
  it "with location and correct key" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi"
    }
    user = User.create!(user_data)
    user.favorites.create!(location: "Denver, CO")
    user.favorites.create!(location: "Dallas, TX")

    user_api_key = {
      "location": "Denver, CO",
      "api_key": user.api_key
    }

    delete "/api/v1/favorites", params: user_api_key
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)["data"]
    expect(body.count).to eq(1)
    expect(body.first["location"]).to eq("Dallas, TX")

  end

  it "and enters incorrect API key" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi"
    }
    user = User.create!(user_data)
    user.favorites.create!(location: "Denver, CO")
    user.favorites.create!(location: "Dallas, TX")

    user_api_key = {
      "location": "Denver, CO",
      "api_key": "NotTheKeyYouWant"
    }

    delete "/api/v1/favorites", params: user_api_key
    expect(response.status).to eq(401)
    body = JSON.parse(response.body)
    expect(user.favorites.count).to eq(2)

  end

  it "and enters a non-existent location" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi"
    }
    user = User.create!(user_data)
    user.favorites.create!(location: "Denver, CO")
    user.favorites.create!(location: "Dallas, TX")

    user_api_key = {
      "location": "Honolulu, HI",
      "api_key": user.api_key
    }

    delete "/api/v1/favorites", params: user_api_key
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(user.favorites.count).to eq(2)

  end
end
