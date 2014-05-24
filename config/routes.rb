Rails.application.routes.draw do
  resources :popular_gems
  root to: 'popular_gems#index'
  get '/downloads/', to: 'popular_gems#most_downloaded', as: :most_downloaded
  get '/hearts/', to: 'popular_gems#most_hearted', as: :most_hearted
  resources :comments
  resource :search
  resources :user
  resource :heart

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

end
