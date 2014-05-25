class PopularGemsController < ApplicationController
  def index
    @top_downloaded_gems = PopularGem.top_downloaded(10)
    @top_hearted_gems = PopularGem.order('cached_votes_score').reverse[0..9]
  end

  def show
    @popular_gem = PopularGem.find(params[:id])
    @comments = @popular_gem.comments.order('cached_votes_score').reverse
    @comment = Comment.new
  end

  def edit
    @popular_gem = PopularGem.find(params[:id])
    GemImporter.update_gem(@popular_gem.name)
    redirect_to @popular_gem
  end

  def most_downloaded
    @gems = PopularGem.top_downloaded.pagination(params[:page])
    end

  def most_hearted
    @gems = Kaminari.paginate_array(PopularGem.order('cached_votes_score').reverse).page(params[:page]).per(10)
  end

  def like
    user = User.find(params[:user_id])
    gem = PopularGem.find(params[:id])
    user.likes gem
    redirect_to :back
  end

  def unlike
    user = User.find(params[:user_id])
    gem = PopularGem.find(params[:id])
    user.dislikes gem
    redirect_to :back
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end