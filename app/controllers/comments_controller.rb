require 'embedly'

class CommentsController < ApplicationController
  def create
    comment = params[:comment][:body]
    if comment.blank?
      @comment = Comment.new
      @gem = PopularGem.friendly.find(params[:comment][:popular_gem])
      @comments = @gem.comments.order(cached_votes_score: :desc)
      render "popular_gems/show"
    else
      if comment.starts_with?("http")
        user = User.find(params[:comment][:user])
        gem = PopularGem.find(params[:comment][:popular_gem])
        embedly_api = Embedly::API.new :key => ENV['EMBEDLY'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
        obj = embedly_api.oembed :url => params[:comment][:body], maxwidth: 500
        if obj.first.provider_name == 'Imgur'
          Comment.create(body: "<img src=#{obj.first.thumbnail_url}>",
                         user: user,
                         popular_gem: gem)
        elsif obj.first.provider_name == 'GitHub' || obj.first.provider_name == 'YouTube'
          Comment.create(body: obj.first.html,
                         user: user,
                         popular_gem: gem)
        else
          @comment = Comment.create_from_gem_page(comment_params)
          if !@comment.valid?
            @gem = PopularGem.friendly.find(params[:comment][:popular_gem])
            @comments = @gem.comments.order(cached_votes_score: :desc)
            render "popular_gems/show"
          end
          current_user.add_points(3)
        end
      else
        @comment = Comment.create_from_gem_page(comment_params)
        if !@comment.valid?
          @gem = PopularGem.friendly.find(params[:comment][:popular_gem])
          @comments = @gem.comments.order(cached_votes_score: :desc)
          render "popular_gems/show"
        end
        current_user.add_points(3)
      end
      gem = PopularGem.friendly.find(params[:comment][:popular_gem])
      redirect_to gem
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    gem = comment.popular_gem
    comment.destroy
    current_user.subtract_points(3)
    redirect_to gem
  end

  def up_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    if user.voted_down_on? comment
      user.likes comment
      comment.user.add_points(20)
    elsif user.voted_up_on? comment
      comment.unliked_by user
      comment.user.subtract_points(10)
    else
      user.likes comment
      comment.user.add_points(10)
    end
    redirect_to :back
  end

  def down_vote
    comment = Comment.find(params[:id])
    user = User.find(params[:user_id])
    if user.voted_up_on? comment
      user.dislikes comment
      comment.user.subtract_points(20)
    elsif user.voted_down_on? comment
      comment.undisliked_by user
      comment.user.add_points(10)
    else
      user.dislikes comment
      comment.user.subtract_points(10)
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user, :popular_gem)
  end
end