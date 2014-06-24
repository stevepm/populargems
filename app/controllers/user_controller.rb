class UserController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    # @comments = @user.comments.limit(5).order(created_at: :desc).includes(:commentable)
    @loved_gems = Kaminari.paginate_array(@user.votes.up.for_type(PopularGem).votables).page(params[:page])
    set_meta_tags :title => "#{@user.name}",
                  :description => "#{@user.name}'s profile'",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@user.name}",
                  :reverse => true
  end

  # def all_comments
  #   @user = User.friendly.find(params[:id])
  #   @comments = @user.comments.order(created_at: :desc).includes(:commentable).pagination(params[:page])
  #   set_meta_tags :title => "#{@user.name}",
  #                 :description => "#{@user.name}'s comments'",
  #                 :keywords => "Ruby, gems, ruby gems, rails, #{@user.name}",
  #                 :reverse => true
  # end
  #
  # def all_likes
  #   @user = User.friendly.find(params[:id])
  #   @loved_gems = Kaminari.paginate_array(@user.votes.up.for_type(PopularGem).votables).page(params[:page])
  #   set_meta_tags :title => "#{@user.name}",
  #                 :description => "#{@user.name}'s likes'",
  #                 :keywords => "Ruby, gems, ruby gems, rails, #{@user.name}",
  #                 :reverse => true
  # end
end