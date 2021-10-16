Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :users, only: %i[ create ]
    get 'validation/unique', to: 'validations#unique'
  end
  get "*path", to: "home#index"


end
