class UserController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @comments = @user.comments.limit(5).order(created_at: :desc).includes(:commentable)
    @loved_gems = @user.votes.up.for_type(PopularGem).votables[0..4]
    set_meta_tags :title => "#{@user.name}",
                  :description => "#{@user.name}'s profile'",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@user.name}"
  end
end