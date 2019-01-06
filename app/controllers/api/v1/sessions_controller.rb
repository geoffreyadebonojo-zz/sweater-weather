class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        key: "thisIsYourApiKey.UR#WLCERZ"
      }, status: 200
    else
      render json: {
        message: "something went wrong!"
      }, status: 400
    end
  end
end
