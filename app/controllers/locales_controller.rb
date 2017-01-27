class LocalesController < ApplicationController
  def show
    #if current_user
    #  current_user.locale = params[:locale]
    #  current_user.save
    #end
    session[:locale] = params[:locale]
    redirect_to :back
  end
end
