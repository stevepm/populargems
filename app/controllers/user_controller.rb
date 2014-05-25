class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = @user.comments
    @loved_gems = @user.votes.up.for_type(PopularGem).votables
  end
end