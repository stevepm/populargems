Rails.application.routes.draw do
  resources :popular_gems
  root to: 'popular_gems#index'
  resources :comments
  resource :search
  resources :user

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

end
