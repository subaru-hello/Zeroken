Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    namespace :v1 do
    resources :users , only: %i[ create index ] do
      get 'tell_on', on: :collection
    end
    resource :sessions, only: %i[ create destroy ]
    resources :alcohols

    resources :analyzes
  get 'validation/unique', to: 'validations#unique'
  end
end
  get "*path", to: "home#index"
end
