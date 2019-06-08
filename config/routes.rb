Rails.application.routes.draw do

  post 'hooks/stripe'

  get '/profile', to: 'dashboards#profile'
  get '/admin', to: 'dashboards#admin'

  get 'sub', to: 'subscriptions#sub'
  post 'new_sub', to: 'subscriptions#new_sub'
  delete 'cancel_sub', to: 'subscriptions#cancel_sub'


  resources :packs, only: [:show] do
    collection do
      get 'shop'
    end

    member do
      post 'download'
    end
  end

  namespace :admin do
    get 'new_user_pack', to: 'packs#new_user_pack'
    post 'gift', to: 'packs#gift'
    resources :packs, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :subscriptions, only: [:new, :create]
  end

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
