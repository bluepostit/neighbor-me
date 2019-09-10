Rails.application.routes.draw do
  devise_for :users
  root to: 'tools#index'

  resources :tools do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, except: %i[new create]
end
