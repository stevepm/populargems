class PopularGemsController < ApplicationController
  def index
    @top_downloaded_gems = PopularGem.top_downloaded(10)
    @top_hearted_gems = PopularGem.top_hearted(10)
  end

  def show
    @popular_gem = PopularGem.find(params[:id])
    @comments = @popular_gem.comments.order('cached_votes_score')
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
    @gems = Kaminari.paginate_array(PopularGem.top_hearted).page(params[:page]).per(10)
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end