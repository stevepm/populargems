Rails.application.routes.draw do
  resources :popular_gems
  root to: 'popular_gems#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

end
