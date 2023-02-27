# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'posts#index'
    resources :posts, only: %i[show new create] do
      scope module: :posts do
        post '/comments', to: 'comments#create'
        resources :likes, shallow: true, only: %i[create destroy]
      end
    end
  end
  devise_for :users
end
