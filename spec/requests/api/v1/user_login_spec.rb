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
    expect(body["key"]).to eq(User.first.api_key)
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
    expect(body["key"]).to eq(user.api_key)
  end

  it "API won't let user log in to session with incorrect password" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    }
    user = User.create!(user_data)
    bad_data = {
    "email": "awesomesauce@gmail.com",
    "password": "wrong_password_dude",
    }
    post "/api/v1/sessions", params: bad_data

    expect(response.status).to eq(400)
    body = JSON.parse(response.body)
    expect(body["key"]).to be_nil
    expect(body["message"]).to eq("something went wrong!")

  end
end
