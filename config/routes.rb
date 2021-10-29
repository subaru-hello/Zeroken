Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    
    resources :users , only: %i[ create index ] do
      get 'tell_on', on: :collection
    end
    resource :sessions, only: %i[ create destroy ]
    resource :alcohols, only: %i[ create index ]
    resource :analyzes, only: %i[ create index ]
    get 'validation/unique', to: 'validations#unique'
  end
  get "*path", to: "home#index"
end
