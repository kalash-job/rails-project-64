# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  scope module: :web do
    root to: 'posts#index'
    resources :posts, only: %i[show new create]
    #     resources :posts, only: %i[show new create] do
    #       scope module: :posts do
    #         resources :comments, only: [:create, :edit, :update, :destroy]
    #       end
    #     end
  end
end
