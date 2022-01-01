Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    namespace :v1 do
    resources :users , only: %i[ create index ] do
      get 'me', on: :collection
    end
    resource :sessions, only: %i[ create destroy ]
    resources :alcohols, only: %i[new, create, index]
    resource :profile, only: %i[update edit] do
      patch 'password', on: :member
    end
    resources :analyzes, except: [:edit, :destroy]
    post 'guest_login', to: 'guest_login#create'
  get 'validation/unique', to: 'validations#unique'
  resources :my_shuchedules, only: %i[new index create update]
  end
end
  get "*path", to: "home#index", constraints: lambda { |req|
    # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
    req.path.exclude? 'rails/active_storage'
  }
end
