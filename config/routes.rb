Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :users, only: %i[ create ]
  end
  get "*path", to: "home#index"


end
