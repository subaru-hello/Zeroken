Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    namespace :v1 do
    resources :users , only: %i[ create index ] do
      get 'tell_on', on: :collection
    end
    resource :sessions, only: %i[ create destroy ]
    resources :alcohols
    resource :profile, only: %i[update] do
      patch 'password', on: :member
    end
    resources :analyzes
    post 'guest_login', to: 'sessions#guest_login'
  get 'validation/unique', to: 'validations#unique'
  end
end
  get "*path", to: "home#index", constraints: lambda { |req|
    # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
    req.path.exclude? 'rails/active_storage'
  }
end
