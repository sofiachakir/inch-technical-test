class BuildingsController < ApplicationController
  def index
  	@buildings = Building.all.order(:reference)
  end

  def import
		response = Building.import(params[:file])
		redirect_to buildings_path, notice: response
	end
end
