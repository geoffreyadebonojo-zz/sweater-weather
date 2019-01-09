
class Api::V1::ForecastsController < ApplicationController

  def index
    location = params[:location] || "Denver, CO"
    @data = GeocodeService.new(location).lat_lng
    render json: {data: ForecastsFacade.new.create_forecast(@data, location)}
  end

end
