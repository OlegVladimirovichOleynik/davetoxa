Rails.application.routes.draw do
  root 'posts#index'
  devise_for(
    :users,
    only: [:sessions, :registrations, :omniauth_callbacks],
    controllers: { omniauth_callbacks: 'omniauth' }
  )

  resources :subscribes, except: [:edit, :show]
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :profile, only: [:show, :edit, :update]

  resources :friendships, only: [:index, :destroy] do
    member do
      put 'invite'
      put 'accept'
      delete 'reject'
   end
  end

  resources :users, only: :index
  resource :search, only: :show, controller: :search

  namespace :admin do
    root 'main#index'
    resources :users, only: :index
  end
end
