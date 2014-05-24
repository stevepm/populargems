class SearchesController < ApplicationController
  def show
    gem_name = params[:gem_name]
    if gem = PopularGem.find_by_name(gem_name)
      redirect_to gem
    else
      if gem = GemImporter.seed_db(gem_name)
        redirect_to gem
      else
        flash[:notice] = "That gem does not exist"
        redirect_to :back
      end
    end
  end
end