Rails.application.routes.draw do
  resources :popular_gems
  root to: 'popular_gems#index'
end
