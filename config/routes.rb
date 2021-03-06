Rails.application.routes.draw do
  resources :popular_gems, path: 'gems'
  put '/popular_gems/:id/like/:user_id', to: 'popular_gems#like', as: :like_gem
  put '/popular_gems/:id/unlike/:user_id', to: 'popular_gems#unlike', as: :unlike_gem
  root to: 'popular_gems#index'
  get '/downloads/', to: 'popular_gems#most_downloaded', as: :most_downloaded
  get '/active/', to: 'popular_gems#most_active', as: :most_active
  get '/hearts/', to: 'popular_gems#most_hearted', as: :most_hearted
  get '/popular_gems/:id/likes', to: 'popular_gems#likes', as: :gem_likes

  resources :comments
  post '/comments/:id/up_vote/:user_id', to: 'comments#up_vote', as: :up_vote_comment
  post '/comments/:id/down_vote/:user_id', to: 'comments#down_vote', as: :down_vote_comment

  resource :search

  resources :user
  get '/user/:id/comments', to: 'user#all_comments', as: :user_comments
  get '/user/:id/likes', to: 'user#all_likes', as: :user_likes

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout

  resources :stats, only: [:index]

  post '/receive_data', to: 'webhook#get_data'
end
