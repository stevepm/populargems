class SearchesController < ApplicationController
  def show
    response = PopularGem.search params[:gem_name]
    @results = response.records.pagination(params[:page])
  end
end