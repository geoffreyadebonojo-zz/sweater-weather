class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      user.favorites.create!(location: params[:location])
    else
      render json: {
        message: "something went wrong!"
      }, status: 401
    end
  end

  def index
    user = User.find_by(api_key: params[:api_key])
    render json: user.favorites
  end
end
