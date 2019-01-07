
class Api::V1::ForecastsController < ApplicationController

  def index
    @data = GeocodeService.new(params[:location]).lat_lng
    render json: {data: ForecastsFacade.new.create_forecast(@data, params)}
  end

end
