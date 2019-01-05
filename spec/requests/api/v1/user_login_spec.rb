require 'rails_helper'

RSpec.describe "User login" do
  it "API recieves post request" do
    
    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    "password_confirmation": "abc123doremi"
    }    

    post "/api/v1/users", params: data

    expect(response).to be_successful
    expect(response.body).to eq("{\"message\":\"Sucessfully created! Here's your key\",\"key\":\"abc123doreimi\"}")
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
    expect(response.body).to eq("{\"data\":\"problem occured!\"}")
    expect(User.count).to eq(0)
  end
end