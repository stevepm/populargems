class WebhookController < ApplicationController
  protect_from_forgery with: :exception, except: :get_data

  def get_data
    @name = allowed_params[:name]
    if PopularGem.find_by_name(@name)
      GemImporter.update_gem(@name)
    else
      GemImporter.seed_db(@name)
    end
    render text: ''
  end

  private
  def allowed_params
    params.permit!
  end
end