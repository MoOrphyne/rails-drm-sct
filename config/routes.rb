Rails.application.routes.draw do

  get '/profile', to: 'dashboards#profile'
  get '/admin', to: 'dashboards#admin'
  delete '/unsubscribe', to: 'subscriptions#unsubscribe'

  resources :packs, only: [:index, :show, :new, :create]
  resources :subscriptions, only: [:new, :create]
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
