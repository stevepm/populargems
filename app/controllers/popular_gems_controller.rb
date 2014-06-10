class PopularGemsController < ApplicationController
  def index
    @top_downloaded_gems = PopularGem.top_downloaded(10)
    @top_hearted_gems = PopularGem.top_hearted(10)
    @recent_comments = Comment.recent_comments
    @featured_gems = PopularGem.featured
    set_meta_tags :title => 'Ruby Gem discovery engine',
                  :description => 'Discover the most downloaded and most loved Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails, top ruby gems, top rubygems,
 top rails gems, popular rubygems, popular ruby gems, popular gems, top gems, popular rails gems,
list of top gems, list of top ruby gems, list of top rubygems, list of top rails gems'
  end

  def show
    @gem = PopularGem.friendly.find(params[:id])
    @comments = @gem.comment_threads.order(cached_votes_score: :desc)
    @comment = Comment.new
    set_meta_tags :title => "#{@gem.name}",
                  :description => "#{@gem.description}",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@gem.name}",
                  :reverse => true
  end

  def edit
    gem = PopularGem.friendly.find(params[:id])
    GemImporter.update_gem(gem.name)
    redirect_to gem
  end

  def most_downloaded
    @top_downloaded_gems = PopularGem.top_downloaded.pagination(params[:page])
    set_meta_tags :title => 'Most downloaded',
                  :description => 'Discover the most downloaded Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails'
  end

  def most_hearted
    @top_hearted_gems = PopularGem.top_hearted.pagination(params[:page])
    set_meta_tags :title => 'Most loved',
                  :description => 'Discover the most loved Ruby Gems',
                  :keywords => 'Ruby, gems, ruby gems, rails'
  end

  def like
    gem = PopularGem.friendly.find(params[:id])

    PopularGem.without_timestamps do
      if current_user.liked?(gem)
        current_user.dislikes gem
        current_user.subtract_points(1)
      else
        current_user.likes gem
        current_user.add_points(1)
      end
    end

    render json: {gem: gem, likes: current_user.liked?(gem)}
  end

  def likes
    @gem = PopularGem.friendly.find(params[:id])
    @users = @gem.votes_for.up.by_type(User).voters
    set_meta_tags :title => "#{@gem.name} likes",
                  :description => "Users that like #{@gem.name}",
                  :keywords => "Ruby, gems, ruby gems, rails, #{@gem.name}"
  end

  private
  def gem_params
    params.require(:popular_gem).permit(:name)
  end
end