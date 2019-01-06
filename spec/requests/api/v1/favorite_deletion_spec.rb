require 'rails_helper'

RSpec.describe "User DELETES a favorite" do
  it "and succeeds" do
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
    body = JSON.parse(response.body)
    expect(body.count).to eq(1)
    expect(body.first["location"]).to eq("Dallas, TX")

  end
end
