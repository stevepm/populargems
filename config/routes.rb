Rails.application.routes.draw do
  resources :popular_gems
  root to: 'popular_gems#index'
  get '/downloads/', to: 'popular_gems#most_downloaded', as: :most_downloaded
  get '/hearts/', to: 'popular_gems#most_hearted', as: :most_hearted
  resources :comments
  post '/comments/:id/up_vote/:user_id', to: 'comments#up_vote', as: :up_vote_comment
  post '/comments/:id/down_vote/:user_id', to: 'comments#down_vote', as: :down_vote_comment
  resource :search
  resources :user
  resource :heart

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

end
