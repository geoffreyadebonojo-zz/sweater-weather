require 'rails_helper'

RSpec.describe "User GETS favorites" do
  it "favorites are there" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi"
    }
    user = User.create!(user_data)
    user.favorites.create!(location: "Denver, CO")
    user.favorites.create!(location: "Dallas, TX")

    user_api_key = {
      "api_key": user.api_key
    }

    get "/api/v1/favorites", params: user_api_key
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
    expect(body.first["location"]).to eq("Denver, CO")
    expect(body.last["location"]).to eq("Dallas, TX")
  end
end
