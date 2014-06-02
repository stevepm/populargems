Rails.application.routes.draw do
  resources :popular_gems
  put '/popular_gems/:id/like/:user_id', to: 'popular_gems#like', as: :like_gem
  put '/popular_gems/:id/unlike/:user_id', to: 'popular_gems#unlike', as: :unlike_gem
  root to: 'popular_gems#index'
  get '/downloads/', to: 'popular_gems#most_downloaded', as: :most_downloaded
  get '/hearts/', to: 'popular_gems#most_hearted', as: :most_hearted
  get '/popular_gems/:id/likes', to: 'popular_gems#likes', as: :gem_likes

  resources :comments
  post '/comments/:id/up_vote/:user_id', to: 'comments#up_vote', as: :up_vote_comment
  post '/comments/:id/down_vote/:user_id', to: 'comments#down_vote', as: :down_vote_comment

  resource :search

  resources :user

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

  post '/receive_data', to: 'webhook#get_data'
end
