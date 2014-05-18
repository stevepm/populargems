class PopularGemsController < ApplicationController
  def index
    @popular_gem = PopularGem.new
  end

  def create

  end
end