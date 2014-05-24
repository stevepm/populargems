class HeartsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    gem = PopularGem.find(params[:popular_gem_id])
    Heart.create(user: user, popular_gem: gem)
    redirect_to :back
  end

  def update
    user = User.find(params[:user_id])
    gem = PopularGem.find(params[:popular_gem_id])
    user.hearts.where(popular_gem: gem).destroy_all
    redirect_to :back
  end
end