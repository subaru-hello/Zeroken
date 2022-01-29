Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    namespace :v1 do
    resources :users , only: %i[ create index ] do
      get 'me', on: :collection
    end
    resource :sessions, only: %i[ create destroy ]
    resources :alcohols, only: %i[new create index]
    resource :profiles, only: %i[update edit ] do
      patch 'password', on: :member
    end
    resources :analyze_results,  only: %i[ create index show edit update]
    resources :questions,  only: %i[ create index]
    resources :answers,  only: %i[ create index]
    resources :tast_answers,  only: %i[ create index shw]
    resources :descriptions,  only: %i[ create index]
    resources :alcohol_in_veins,  only: %i[ create index]
    post 'guest_login', to: 'guest_login#create'
  get 'validation/unique', to: 'validations#unique'
  end
end
  get "*path", to: "home#index", constraints: lambda { |req|
    # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
    req.path.exclude? 'rails/active_storage'
  }
end
