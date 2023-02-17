# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, except: [:index]
  resources :categories
  # get '/users/sign_out', to: 'devise/sessions#destroy'
  devise_for :users
end
