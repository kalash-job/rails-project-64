# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  scope module: :web do
    root to: 'posts#index'
    resources :posts, only: %i[show new create] do
      scope module: :posts do
        resources :comments, only: %i[create]
      end
    end
  end
end
