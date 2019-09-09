Rails.application.routes.draw do
  devise_for :users
  root to: 'tools#index'

  resources :tools
end
