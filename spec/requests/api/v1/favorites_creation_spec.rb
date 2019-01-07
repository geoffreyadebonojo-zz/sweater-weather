require 'rails_helper'

RSpec.describe "User POSTS to favorites" do
  it "and succeeds" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi"
    }
    user = User.create!(user_data)

    login_data = {
      "email": "awesomesauce@gmail.com",
      "password": "abc123doremi"
    }

    post "/api/v1/sessions", params: login_data
    expect(response.status).to eq(200)

    post_data = {
      "location": "Denver, CO",
      "api_key": user.api_key
    }

    post "/api/v1/favorites", params: post_data

    expect(Favorite.count).to eq(1)
    expect(User.first.favorites.first.location).to eq("Denver, CO")

    expect(response.status).to eq(200)
  end

  it "and it refuses users POST if api key is incorrect" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi"
    }
    user = User.create!(user_data)

    login_data = {
      "email": "awesomesauce@gmail.com",
      "password": "abc123doremi"
    }

    post "/api/v1/sessions", params: login_data
    expect(response.status).to eq(200)

    post_data = {
      "location": "Denver, CO",
      "api_key": "ThisKeyIsIncorrect"
    }

    post "/api/v1/favorites", params: post_data

    expect(Favorite.count).to eq(0)

    expect(response.status).to eq(401)
  end
end
