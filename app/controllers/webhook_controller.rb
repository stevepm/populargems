class WebhookController < ApplicationController
  protect_from_forgery with: :exception, except: :get_data

  def get_data
    @name = allowed_params[:name]
    if gem = PopularGem.find_by_name(@name)
      UpdateGemJob.new.async.perform(gem)
    else
      CreateNewGemJob.new.async.perform(@name)
    end
    render text: ''
  end

  private
  def allowed_params
    params.permit!
  end
end