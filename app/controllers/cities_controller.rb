class CitiesController < ApplicationController
  def search
    respond_to do |format|
      format.html
      format.json { @cities = City.search(params[:term]) if params[:term] }
    end
  end
end
