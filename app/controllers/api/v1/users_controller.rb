class Api::V1::UsersController < ApplicationController

  def index
    render json: UserSerializer.new(User.all)
  end

  def create
    user = User.new(user_params)
    if user.save && validation
      render json: {
        message: "Sucessfully created! Here's your key",
        key: "thisIsYourApiKey.UR#WLCERZ"
      }, status: 200
    else
      render json: {message: "problem occured!"}, status: 400
    end

  end

  private

  def validation
    params[:password] == params[:password_confirmation]
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
