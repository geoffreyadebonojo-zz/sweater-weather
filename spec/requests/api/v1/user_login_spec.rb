require 'rails_helper'

RSpec.describe "User login" do
  it "API recieves post request, creates user" do

    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    "password_confirmation": "abc123doremi"
    }

    post "/api/v1/users", params: data

    expect(response).to be_successful
    body = JSON.parse(response.body)
    expect(body["key"]).to eq("thisIsYourApiKey.UR#WLCERZ")
    expect(body["message"]).to eq("Sucessfully created! Here's your key")
    expect(User.last.email).to eq("awesomesauce@gmail.com")
  end

  it "API rejects post request with wrong password" do

    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    "password_confirmation": "youandme"
    }

    post "/api/v1/users", params: data

    expect(response.status).to eq(400)
    body = JSON.parse(response.body)
    expect(body["message"]).to eq("problem occured!")
    expect(User.count).to eq(0)
  end

  it "API lets user log in to session with password" do
    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    }
    user = User.create!(data)

    post "/api/v1/sessions", params: data

    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body["key"]).to eq("thisIsYourApiKey.UR#WLCERZ")
    binding.pry
  end
end
