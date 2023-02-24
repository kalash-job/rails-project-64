# frozen_string_literal: true

Rails.application.routes.draw do
  # root 'posts#index'
  # resources :posts, except: [:index]
  # post '/comments', to: 'comments#create'
  # devise_for :users

  scope module: :web do
    root 'posts#index'
    resources :posts, only: %i[show new create] do
      scope module: :posts do
        # resources :comments, only: %i[create]
        post '/comments', to: 'comments#create'
      end
    end
  end
  devise_for :users
end
