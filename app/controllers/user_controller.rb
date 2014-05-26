class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = @user.comments
    @loved_gems = @user.votes.up.for_type(PopularGem).votables
    set_meta_tags :title => "#{@user.name}",
                  :description => "#{@user.name}'s profile'",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@user.name}"
  end
end