class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = @user.comments
  end
end