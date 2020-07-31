class PeopleController < ApplicationController
  def index
		@people = Person.all.order(:reference)
	end

	def import
		response = Person.import(params[:file])
		redirect_to people_path, notice: response
	end
end
