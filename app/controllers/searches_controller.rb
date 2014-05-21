class SearchesController < ApplicationController
  def show
    if gem = PopularGem.find_by_name(params[:gem_name])
      redirect_to gem
    else
      flash[:notice] = "That gem does not exist"
      redirect_to :back
    end
  end
end